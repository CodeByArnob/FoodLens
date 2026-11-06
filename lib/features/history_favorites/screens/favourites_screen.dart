import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/food_image_view.dart';
import '../providers/history_favorites_provider.dart';

class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyFavoritesProvider);
    final notifier = ref.read(historyFavoritesProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Favourite Dishes'),
        leading: const BackButton(color: Colors.white),
      ),
      body: state.favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 54,
                    color: AppColors.textMutedDark,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No favourite dishes yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tap the heart icon on any scanned food to save it here.',
                    style: TextStyle(
                      color: AppColors.textMutedDark,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              itemCount: state.favorites.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = state.favorites[index];
                return GlassCard(
                  padding: const EdgeInsets.all(16),
                  onTap: () {
                    HapticHelper.lightImpact();
                    context.push('/analysis-result', extra: item);
                  },
                  child: Row(
                    children: [
                      FoodImageView(
                        imagePath: item.imagePath,
                        foodName: item.foodName,
                        width: 48,
                        height: 48,
                        borderRadius: 12,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.foodName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${item.cuisine} • ${item.calories} kcal',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textMutedDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.favorite_rounded,
                          color: AppColors.accentRose,
                        ),
                        onPressed: () {
                          HapticHelper.lightImpact();
                          notifier.toggleFavorite(item);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
