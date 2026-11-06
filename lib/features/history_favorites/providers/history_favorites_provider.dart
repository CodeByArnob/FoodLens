import 'package:flutter_riverpod/legacy.dart';
import '../../scanner/models/food_analysis_result.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/services/local_storage_service.dart';

class HistoryFavoritesState {
  final List<FoodAnalysisResult> history;
  final List<FoodAnalysisResult> favorites;
  final String searchQuery;
  final String? selectedFilterTag;

  const HistoryFavoritesState({
    this.history = const [],
    this.favorites = const [],
    this.searchQuery = '',
    this.selectedFilterTag,
  });

  List<FoodAnalysisResult> get filteredHistory {
    return history.where((item) {
      final matchesQuery = searchQuery.isEmpty ||
          item.foodName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.cuisine.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesTag = selectedFilterTag == null ||
          item.dietaryTags.contains(selectedFilterTag);

      return matchesQuery && matchesTag;
    }).toList();
  }

  List<FoodAnalysisResult> get filteredFavorites {
    return favorites.where((item) {
      final matchesQuery = searchQuery.isEmpty ||
          item.foodName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.cuisine.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesTag = selectedFilterTag == null ||
          item.dietaryTags.contains(selectedFilterTag);

      return matchesQuery && matchesTag;
    }).toList();
  }

  HistoryFavoritesState copyWith({
    List<FoodAnalysisResult>? history,
    List<FoodAnalysisResult>? favorites,
    String? searchQuery,
    String? selectedFilterTag,
    bool clearTag = false,
  }) {
    return HistoryFavoritesState(
      history: history ?? this.history,
      favorites: favorites ?? this.favorites,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilterTag: clearTag ? null : (selectedFilterTag ?? this.selectedFilterTag),
    );
  }
}

final historyFavoritesProvider =
    StateNotifierProvider<HistoryFavoritesNotifier, HistoryFavoritesState>((ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return HistoryFavoritesNotifier(storage);
});

class HistoryFavoritesNotifier extends StateNotifier<HistoryFavoritesState> {
  final LocalStorageService _storage;

  HistoryFavoritesNotifier(this._storage) : super(const HistoryFavoritesState()) {
    refresh();
  }

  Future<void> refresh() async {
    var history = _storage.getScanHistory();
    var favorites = _storage.getFavorites();

    if (history.isEmpty) {
      final seed = await _storage.loadSeedDatabase();
      if (seed.isNotEmpty) {
        for (final item in seed) {
          await _storage.saveScanResult(item);
        }
        history = _storage.getScanHistory();
      }
    }

    if (favorites.isEmpty && history.isNotEmpty) {
      await _storage.toggleFavorite(history.first);
      favorites = _storage.getFavorites();
    }

    state = state.copyWith(
      history: history,
      favorites: favorites,
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFilterTag(String? tag) {
    if (state.selectedFilterTag == tag) {
      state = state.copyWith(clearTag: true);
    } else {
      state = state.copyWith(selectedFilterTag: tag);
    }
  }

  Future<void> toggleFavorite(FoodAnalysisResult item) async {
    await _storage.toggleFavorite(item);
    await refresh();
  }

  Future<void> deleteHistoryItem(String id) async {
    await _storage.deleteScanResult(id);
    await refresh();
  }

  Future<void> clearAllHistory() async {
    await _storage.clearScanHistory();
    await refresh();
  }
}
