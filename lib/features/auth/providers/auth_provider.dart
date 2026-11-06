import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../shared/services/local_storage_service.dart';
import '../models/puter_user.dart';
import '../models/puter_usage.dart';
import '../services/puter_bridge_service.dart';
import '../../../core/errors/app_exception.dart';

// Providers
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError(
    'localStorageServiceProvider must be overridden in main',
  );
});

final puterBridgeServiceProvider = Provider<PuterBridgeService>((ref) {
  final storage = ref.watch(localStorageServiceProvider);
  final bridge = PuterBridgeService(storage);
  ref.onDispose(() => bridge.dispose());
  return bridge;
});

class AuthState {
  final PuterUser? user;
  final PuterUsage? usage;
  final bool isLoading;
  final bool isBridgeReady;
  final String? errorMessage;
  final bool hasExhaustedAllowance;

  const AuthState({
    this.user,
    this.usage,
    this.isLoading = false,
    this.isBridgeReady = false,
    this.errorMessage,
    this.hasExhaustedAllowance = false,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    PuterUser? user,
    PuterUsage? usage,
    bool? isLoading,
    bool? isBridgeReady,
    String? errorMessage,
    bool? hasExhaustedAllowance,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      usage: usage ?? this.usage,
      isLoading: isLoading ?? this.isLoading,
      isBridgeReady: isBridgeReady ?? this.isBridgeReady,
      errorMessage: errorMessage,
      hasExhaustedAllowance:
          hasExhaustedAllowance ?? this.hasExhaustedAllowance,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final bridge = ref.watch(puterBridgeServiceProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return AuthNotifier(bridge, storage);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final PuterBridgeService _bridge;
  final LocalStorageService _storage;

  AuthNotifier(this._bridge, this._storage) : super(const AuthState()) {
    _init();
  }

  Future<void> _init() async {
    // 1. Immediately restore cached session from local storage in 0ms!
    final cachedToken = _storage.getPuterToken();
    final cachedUsername = _storage.getPuterUsername();
    final cachedUuid = _storage.getPuterUuid();

    if (cachedToken != null &&
        cachedToken.isNotEmpty &&
        cachedUsername != null) {
      state = state.copyWith(
        user: PuterUser(username: cachedUsername, uuid: cachedUuid),
        isLoading: false,
        isBridgeReady: false,
      );
    } else {
      state = state.copyWith(isLoading: false, isBridgeReady: false);
    }

    // 2. Wire event streams
    _bridge.insufficientFundsStream.listen((exc) {
      state = state.copyWith(
        hasExhaustedAllowance: true,
        errorMessage: exc.message,
      );
    });

    _bridge.usageStream.listen((usage) {
      state = state.copyWith(
        usage: usage,
        hasExhaustedAllowance: usage.hasExhaustedAllowance,
      );
    });

    // 3. Initialize Puter Bridge in background without blocking UI
    try {
      await _bridge.initializeBridge();
      state = state.copyWith(isBridgeReady: true);

      // If we have cached token, sync it to WebView
      if (cachedToken != null && cachedToken.isNotEmpty) {
        unawaited(_syncTokenAndFetchUsageAsync(cachedToken));
      } else {
        // Quick session check with 3s timeout
        final session = await _bridge.checkSession(
          timeout: const Duration(seconds: 3),
        );
        if (session['isSignedIn'] == true && session['user'] != null) {
          final user = PuterUser.fromJson(
            session['user'] as Map<String, dynamic>,
          );
          await _storage.setPuterUsername(user.username);
          await _storage.setPuterUuid(user.uuid);
          state = state.copyWith(
            user: user,
            isBridgeReady: true,
            isLoading: false,
          );
          unawaited(_fetchUsageAsync());
        }
      }
    } catch (e) {
      debugPrint('[AuthNotifier] Background init error: $e');
      state = state.copyWith(isBridgeReady: true, isLoading: false);
    }
  }

  Future<void> _syncTokenAndFetchUsageAsync(String token) async {
    try {
      await _bridge.setAuthToken(token);
      final freshUser = await _bridge.getUser();
      if (freshUser != null) {
        state = state.copyWith(user: freshUser);
      }
      final usage = await _bridge.getMonthlyUsage();
      state = state.copyWith(usage: usage);
    } catch (e) {
      debugPrint('[AuthNotifier] Async sync error: $e');
    }
  }

  Future<void> _fetchUsageAsync() async {
    try {
      final usage = await _bridge.getMonthlyUsage();
      state = state.copyWith(usage: usage);
    } catch (e) {
      debugPrint('[AuthNotifier] Async usage fetch error: $e');
    }
  }

  Future<bool> signInWithToken(String token) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final trimmedToken = token
          .trim()
          .replaceFirst(RegExp(r'^Bearer\s+', caseSensitive: false), '')
          .replaceAll('"', '')
          .replaceAll("'", "");

      if (trimmedToken.isEmpty) {
        throw AppException('Please enter a valid Puter token.');
      }

      PuterUser? user;
      try {
        user = await _bridge.validatePuterTokenViaRest(trimmedToken);
      } catch (e) {
        if (e is PuterAuthException) rethrow;
      }

      if (user == null && trimmedToken.length >= 10) {
        await _bridge.setAuthToken(trimmedToken);
        user = await _bridge.getUser();
        user ??= PuterUser(
          username: 'Puter User',
          uuid: trimmedToken.length > 8
              ? trimmedToken.substring(0, 8)
              : trimmedToken,
        );
      }

      if (user != null) {
        await _storage.setPuterToken(trimmedToken);
        await _storage.setPuterUsername(user.username);
        await _storage.setPuterUuid(user.uuid);
        await _bridge.setAuthToken(trimmedToken);

        state = state.copyWith(
          user: user,
          isLoading: false,
          errorMessage: null,
        );

        unawaited(_fetchUsageAsync());
        return true;
      }
      throw AppException('Unable to verify Puter account token.');
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e is AppException ? e.message : e.toString(),
      );
      return false;
    }
  }

  Future<bool> signInWithPuterWeb() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _bridge.signIn(timeout: const Duration(minutes: 3));
      if (user != null) {
        await _storage.setPuterUsername(user.username);
        await _storage.setPuterUuid(user.uuid);

        state = state.copyWith(
          user: user,
          isLoading: false,
          errorMessage: null,
        );

        unawaited(_fetchUsageAsync());
        return true;
      }
      state = state.copyWith(isLoading: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e is AppException ? e.message : e.toString(),
      );
      return false;
    }
  }

  Future<void> refreshUsage() async {
    try {
      final usage = await _bridge.getMonthlyUsage();
      state = state.copyWith(
        usage: usage,
        hasExhaustedAllowance: usage.hasExhaustedAllowance,
      );
    } catch (e) {
      if (e is PuterInsufficientFundsException) {
        state = state.copyWith(
          hasExhaustedAllowance: true,
          errorMessage: e.message,
        );
      }
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _storage.clearAuth();
      await _bridge.signOut();
    } catch (e) {
      debugPrint('[AuthProvider] Non-fatal signOut error: $e');
    } finally {
      state = state.copyWith(
        clearUser: true,
        usage: null,
        isLoading: false,
        hasExhaustedAllowance: false,
        errorMessage: null,
      );
    }
  }
}
