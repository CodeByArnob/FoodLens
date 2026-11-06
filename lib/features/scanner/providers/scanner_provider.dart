import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import '../services/scanner_service.dart';
import '../models/food_analysis_result.dart';
import '../models/menu_analysis_result.dart';
import '../models/label_analysis_result.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../../../core/errors/app_exception.dart';
import '../../../shared/services/local_storage_service.dart';

final scannerServiceProvider = Provider<ScannerService>((ref) {
  final bridge = ref.watch(puterBridgeServiceProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return ScannerService(bridge, storage);
});

class ScannerState {
  final ScanMode mode;
  final bool isScanning;
  final String? currentStageMessage;
  final String? streamedChunkPreview;
  final XFile? capturedImage;
  final FoodAnalysisResult? lastFoodResult;
  final MenuAnalysisResult? lastMenuResult;
  final LabelAnalysisResult? lastLabelResult;
  final String? errorMessage;
  final bool isFlashOn;

  const ScannerState({
    this.mode = ScanMode.dish,
    this.isScanning = false,
    this.currentStageMessage,
    this.streamedChunkPreview,
    this.capturedImage,
    this.lastFoodResult,
    this.lastMenuResult,
    this.lastLabelResult,
    this.errorMessage,
    this.isFlashOn = false,
  });

  ScannerState copyWith({
    ScanMode? mode,
    bool? isScanning,
    String? currentStageMessage,
    String? streamedChunkPreview,
    XFile? capturedImage,
    FoodAnalysisResult? lastFoodResult,
    MenuAnalysisResult? lastMenuResult,
    LabelAnalysisResult? lastLabelResult,
    String? errorMessage,
    bool? isFlashOn,
    bool clearImage = false,
    bool clearStage = false,
  }) {
    return ScannerState(
      mode: mode ?? this.mode,
      isScanning: isScanning ?? this.isScanning,
      currentStageMessage: clearStage
          ? null
          : (currentStageMessage ?? this.currentStageMessage),
      streamedChunkPreview: clearStage
          ? null
          : (streamedChunkPreview ?? this.streamedChunkPreview),
      capturedImage: clearImage ? null : (capturedImage ?? this.capturedImage),
      lastFoodResult: lastFoodResult ?? this.lastFoodResult,
      lastMenuResult: lastMenuResult ?? this.lastMenuResult,
      lastLabelResult: lastLabelResult ?? this.lastLabelResult,
      errorMessage: errorMessage,
      isFlashOn: isFlashOn ?? this.isFlashOn,
    );
  }
}

final scannerProvider = StateNotifierProvider<ScannerNotifier, ScannerState>((
  ref,
) {
  final service = ref.watch(scannerServiceProvider);
  final settings = ref.watch(settingsProvider);
  final bridge = ref.watch(puterBridgeServiceProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return ScannerNotifier(service, settings, bridge, storage);
});

class ScannerNotifier extends StateNotifier<ScannerState> {
  final ScannerService _service;
  final SettingsState _settings;
  final dynamic _bridge;
  final LocalStorageService _storage;
  StreamSubscription? _stageSub;
  StreamSubscription? _chunkSub;

  ScannerNotifier(this._service, this._settings, this._bridge, this._storage)
    : super(const ScannerState()) {
    _listenToStreams();
  }

  void _listenToStreams() {
    _stageSub = _bridge.aiStageStream.listen((data) {
      if (data is Map<String, dynamic> && data['message'] != null) {
        state = state.copyWith(currentStageMessage: data['message'] as String);
      }
    });

    _chunkSub = _bridge.aiChunkStream.listen((data) {
      if (data is Map<String, dynamic> && data['chunk'] != null) {
        state = state.copyWith(streamedChunkPreview: data['chunk'] as String);
      }
    });
  }

  @override
  void dispose() {
    _stageSub?.cancel();
    _chunkSub?.cancel();
    super.dispose();
  }

  void setMode(ScanMode mode) {
    state = state.copyWith(mode: mode, errorMessage: null);
  }

  void toggleFlash() {
    state = state.copyWith(isFlashOn: !state.isFlashOn);
  }

  void cancelScan() {
    state = state.copyWith(
      isScanning: false,
      clearStage: true,
      errorMessage: 'Scan cancelled by user.',
    );
  }

  Future<bool> captureAndScan(ImageSource source) async {
    state = state.copyWith(
      errorMessage: null,
      streamedChunkPreview: null,
      currentStageMessage: 'Preparing image...',
    );

    final cachedToken = _storage.getPuterToken();
    if (cachedToken == null || cachedToken.trim().isEmpty) {
      state = state.copyWith(
        isScanning: false,
        errorMessage:
            'Puter account authentication required. Please connect your Puter account or token.',
      );
      return false;
    }

    final image = await _service.pickImage(source);
    if (image == null) return false;

    state = state.copyWith(
      capturedImage: image,
      isScanning: true,
      currentStageMessage: 'Connecting to Puter AI...',
    );

    try {
      switch (state.mode) {
        case ScanMode.dish:
          final prefsSummary = _settings.dietaryFilters.join(', ');
          final food = await _service.scanDish(
            image,
            userPreferences: prefsSummary,
            languageCode: _settings.language,
            languageName: _settings.languageNativeName,
          );
          state = state.copyWith(
            isScanning: false,
            currentStageMessage: null,
            lastFoodResult: food,
          );
          return true;

        case ScanMode.menu:
          final menu = await _service.scanMenu(
            image,
            currencySymbol: _settings.currencySymbol,
            languageCode: _settings.language,
          );
          state = state.copyWith(
            isScanning: false,
            currentStageMessage: null,
            lastMenuResult: menu,
          );
          return true;

        case ScanMode.nutritionLabel:
          final label = await _service.scanNutritionLabel(
            image,
            languageCode: _settings.language,
          );
          final convertedFood = FoodAnalysisResult(
            foodName: label.productName,
            isVerifiedLabel: true,
            confidenceScore: label.confidenceScore,
            portionSize: label.servingSize,
            calories: label.calories,
            fat: label.fat,
            saturatedFat: label.saturatedFat,
            carbohydrates: label.carbohydrates,
            fiber: label.fiber,
            sugar: label.sugar,
            protein: label.protein,
            sodium: label.sodium,
            potassium: label.potassium,
            calcium: label.calcium,
            iron: label.iron,
            ingredients: label.ingredients,
            allergenWarnings: label.allergenWarnings,
            healthScore: label.healthScore,
            imagePath: image.path,
            disclaimer: 'Verified from nutrition facts label via OCR scanning.',
          );

          state = state.copyWith(
            isScanning: false,
            currentStageMessage: null,
            lastLabelResult: label,
            lastFoodResult: convertedFood,
          );
          return true;
      }
    } catch (e) {
      state = state.copyWith(
        isScanning: false,
        currentStageMessage: null,
        errorMessage: e is AppException ? e.message : e.toString(),
      );
      return false;
    }
  }

  void clearResults() {
    state = state.copyWith(
      clearImage: true,
      clearStage: true,
      lastFoodResult: null,
      lastMenuResult: null,
      lastLabelResult: null,
      errorMessage: null,
    );
  }
}
