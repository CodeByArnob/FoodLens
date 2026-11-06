import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/food_image_view.dart';
import '../providers/history_favorites_provider.dart';

class ScanHistoryScreen extends ConsumerWidget {
  const ScanHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(historyFavoritesProvider);
    final notifier = ref.read(historyFavoritesProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: const Text('Scan History'),
        leading: const BackButton(color: Colors.white),
        actions: [
          if (state.history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.textMutedDark),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.darkSurface,
                    title: const Text('Clear Scan History?', style: TextStyle(color: Colors.white)),
                    content: const Text(
                      'This will permanently delete all previously cached scan logs from local storage.',
                      style: TextStyle(color: AppColors.textSecondaryDark),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                      TextButton(
                        onPressed: () {
                          notifier.clearAllHistory();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Clear All', style: TextStyle(color: AppColors.error)),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              onChanged: (q) => notifier.setSearchQuery(q),
              style: const TextStyle(fontSize: 13, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search scanned foods, cuisines...',
                hintStyle: const TextStyle(color: AppColors.textMutedDark, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: AppColors.textMutedDark, size: 20),
                filled: true,
                fillColor: AppColors.darkSurfaceCard,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.darkBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.darkBorder),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // History List
          Expanded(
            child: state.filteredHistory.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.history_toggle_off_rounded, size: 54, color: AppColors.textMutedDark),
                        SizedBox(height: 12),
                        Text('No history items found', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: state.filteredHistory.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = state.filteredHistory[index];
                      return Dismissible(
                        key: ValueKey(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete_outline, color: AppColors.error),
                        ),
                        onDismissed: (_) {
                          notifier.deleteHistoryItem(item.id);
                        },
                        child: GlassCard(
                          padding: const EdgeInsets.all(14),
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
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.calories} kcal • ${item.cuisine}',
                                      style: const TextStyle(fontSize: 11, color: AppColors.textMutedDark),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppColors.darkSurfaceHighlight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Score ${item.healthScore}',
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
