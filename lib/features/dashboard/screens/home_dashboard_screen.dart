import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../core/utils/dashboard_localization_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/calorie_gauge.dart';
import '../../../shared/widgets/macro_donut_chart.dart';
import '../../../shared/widgets/disclaimer_banner.dart';
import '../../../shared/widgets/food_image_view.dart';
import '../../../shared/widgets/puter_auth_required_modal.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../../nutrition_tracking/providers/nutrition_tracker_provider.dart';
import '../../nutrition_tracking/models/daily_log.dart';
import '../../history_favorites/providers/history_favorites_provider.dart';
import '../../scanner/providers/scanner_provider.dart';
import '../../scanner/services/scanner_service.dart';
import '../providers/dashboard_recommendations_provider.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final settings = ref.watch(settingsProvider);
    final trackerState = ref.watch(nutritionTrackerProvider);
    final historyState = ref.watch(historyFavoritesProvider);
    final recommendations = ref.watch(dashboardRecommendationsProvider);
    final todayLog = trackerState.todayLog;
    final l10n = AppLocalizations.of(context);
    final lang = settings.language;

    final user = authState.user;
    final usage = authState.usage;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.darkSurface,
          onRefresh: () async {
            HapticHelper.lightImpact();
            await ref.read(authProvider.notifier).refreshUsage();
            await ref.read(historyFavoritesProvider.notifier).refresh();
            await ref
                .read(dashboardRecommendationsProvider.notifier)
                .loadRecommendations();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Personalized Header & Puter Status
                _DashboardHeader(
                  userName: user?.username,
                  remainingCreditsFormatted: usage?.remainingCreditsFormatted,
                  language: lang,
                  onProfileTap: () {
                    HapticHelper.lightImpact();
                    context.push('/profile');
                  },
                  onCreditsTap: () {
                    HapticHelper.lightImpact();
                    if (user != null) {
                      context.push('/usage');
                    } else {
                      context.push('/auth');
                    }
                  },
                ),
                const SizedBox(height: 18),

                // 2. Primary Hero Action 1: Scan Food Dish
                _ScanFoodHeroCard(
                  language: lang,
                  onScanCamera: () async {
                    HapticHelper.mediumImpact();
                    if (!ref.read(authProvider).isAuthenticated &&
                        !ref.read(puterBridgeServiceProvider).hasToken) {
                      PuterAuthRequiredModal.show(context);
                      return;
                    }
                    ref.read(scannerProvider.notifier).setMode(ScanMode.dish);
                    final success = await ref
                        .read(scannerProvider.notifier)
                        .captureAndScan(ImageSource.camera);
                    if (success && context.mounted) {
                      context.push('/analysis-result');
                    }
                  },
                  onScanGallery: () async {
                    HapticHelper.mediumImpact();
                    if (!ref.read(authProvider).isAuthenticated &&
                        !ref.read(puterBridgeServiceProvider).hasToken) {
                      PuterAuthRequiredModal.show(context);
                      return;
                    }
                    ref.read(scannerProvider.notifier).setMode(ScanMode.dish);
                    final success = await ref
                        .read(scannerProvider.notifier)
                        .captureAndScan(ImageSource.gallery);
                    if (success && context.mounted) {
                      context.push('/analysis-result');
                    }
                  },
                  onOpenScannerScreen: () {
                    HapticHelper.mediumImpact();
                    ref.read(scannerProvider.notifier).setMode(ScanMode.dish);
                    context.push('/scanner');
                  },
                ),
                const SizedBox(height: 14),

                // 3. Primary Hero Action 2: Scan Restaurant Menu
                _ScanMenuHeroCard(
                  language: lang,
                  onScanMenu: () {
                    HapticHelper.mediumImpact();
                    ref.read(scannerProvider.notifier).setMode(ScanMode.menu);
                    context.push('/scanner');
                  },
                ),
                const SizedBox(height: 20),

                // 4. How FoodLens AI Works (Onboarding / Contextual Guidance)
                _HowItWorksGuide(language: lang),
                const SizedBox(height: 22),

                // 5. Today's Nutrition Intelligence Dashboard
                _TodayNutritionSection(
                  todayLog: todayLog,
                  targetCalories: settings.dailyCalorieTarget,
                  language: lang,
                  l10n: l10n,
                  onLogMealTap: () {
                    HapticHelper.lightImpact();
                    context.push('/tracker');
                  },
                  onAddWater: (amount) {
                    HapticHelper.mediumImpact();
                    ref
                        .read(nutritionTrackerProvider.notifier)
                        .addWater(amount);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          DashboardLocalizationHelper.getWaterLoggedToast(
                            lang,
                            amount,
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: AppColors.secondary,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // 6. Personalized AI Food Recommendations
                _AiRecommendationsSection(
                  recommendations: recommendations,
                  language: lang,
                  onDishTap: (dish) {
                    HapticHelper.lightImpact();
                    context.push('/analysis-result', extra: dish.food);
                  },
                ),
                const SizedBox(height: 24),

                // 7. Quick-Access Food Intelligence Grid (6 Essential Hubs)
                _QuickAccessToolsSection(
                  scansCount: historyState.history.length,
                  favoritesCount: historyState.favorites.length,
                  language: lang,
                  l10n: l10n,
                ),
                const SizedBox(height: 24),

                // 8. Recent Food Scans Section
                _RecentScansSection(
                  history: historyState.history,
                  language: lang,
                  l10n: l10n,
                  onScanNowTap: () {
                    HapticHelper.mediumImpact();
                    ref.read(scannerProvider.notifier).setMode(ScanMode.dish);
                    context.push('/scanner');
                  },
                  onItemTap: (item) {
                    HapticHelper.lightImpact();
                    context.push('/analysis-result', extra: item);
                  },
                  onViewAllTap: () {
                    HapticHelper.lightImpact();
                    context.push('/history');
                  },
                ),
                const SizedBox(height: 24),

                // 9. Safety & Medical Disclaimer
                const DisclaimerBanner(isCompact: true),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 1. Dashboard Header
// -------------------------------------------------------------
class _DashboardHeader extends StatelessWidget {
  final String? userName;
  final String? remainingCreditsFormatted;
  final String language;
  final VoidCallback onProfileTap;
  final VoidCallback onCreditsTap;

  const _DashboardHeader({
    required this.userName,
    required this.remainingCreditsFormatted,
    required this.language,
    required this.onProfileTap,
    required this.onCreditsTap,
  });

  @override
  Widget build(BuildContext context) {
    final greeting = DashboardLocalizationHelper.getGreeting(
      language,
      userName,
    );
    final tagline = DashboardLocalizationHelper.getTagline(language);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Avatar Button
        GestureDetector(
          onTap: onProfileTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF059669), Color(0xFF10B981)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Icon(Icons.person_rounded, color: Colors.white, size: 22),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Greeting & Tagline
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                tagline,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMutedDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),

        // Puter Credits / Usage Pill
        GestureDetector(
          onTap: onCreditsTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.puterBlue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.puterBlue.withValues(alpha: 0.4),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.puterBlue.withValues(alpha: 0.15),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  userName != null ? Icons.bolt_rounded : Icons.login_rounded,
                  color: AppColors.secondaryLight,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  userName != null
                      ? (remainingCreditsFormatted ?? '\$10.00')
                      : 'Connect',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondaryLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------
// 2. Primary Hero Action 1: Scan Food Dish
// -------------------------------------------------------------
class _ScanFoodHeroCard extends StatelessWidget {
  final String language;
  final VoidCallback onScanCamera;
  final VoidCallback onScanGallery;
  final VoidCallback onOpenScannerScreen;

  const _ScanFoodHeroCard({
    required this.language,
    required this.onScanCamera,
    required this.onScanGallery,
    required this.onOpenScannerScreen,
  });

  @override
  Widget build(BuildContext context) {
    final title = DashboardLocalizationHelper.getScanFoodTitle(language);
    final subtitle = DashboardLocalizationHelper.getScanFoodSub(language);
    final cameraLabel = DashboardLocalizationHelper.getCaptureCamera(language);
    final galleryLabel = DashboardLocalizationHelper.getUploadGallery(language);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF064E3B), Color(0xFF0F2520), Color(0xFF0B1320)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.5),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: AppColors.primaryLight,
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'AI VISION SCANNER',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryLight,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.camera_alt_rounded,
                color: AppColors.primaryLight,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.5,
              color: AppColors.textSecondaryDark,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: ElevatedButton.icon(
                  onPressed: onScanCamera,
                  icon: const Icon(Icons.camera_rounded, size: 17),
                  label: Text(
                    cameraLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: OutlinedButton.icon(
                  onPressed: onScanGallery,
                  icon: const Icon(Icons.photo_library_outlined, size: 16),
                  label: Text(
                    galleryLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: onOpenScannerScreen,
                tooltip: 'Live Viewfinder',
                icon: const Icon(Icons.crop_free_rounded, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.darkSurfaceCard,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 3. Primary Hero Action 2: Scan Restaurant Menu
// -------------------------------------------------------------
class _ScanMenuHeroCard extends StatelessWidget {
  final String language;
  final VoidCallback onScanMenu;

  const _ScanMenuHeroCard({required this.language, required this.onScanMenu});

  @override
  Widget build(BuildContext context) {
    final title = DashboardLocalizationHelper.getScanMenuTitle(language);
    final subtitle = DashboardLocalizationHelper.getScanMenuSub(language);
    final btnText = DashboardLocalizationHelper.getScanMenuButton(language);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2E3E), Color(0xFF0C1D2E), Color(0xFF0B1320)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3.5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.4),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.secondaryLight,
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'OCR MENU SCANNER',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondaryLight,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.restaurant_menu_rounded,
                color: AppColors.secondaryLight,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondaryDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onScanMenu,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 11),
              ),
              child: Text(
                btnText,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 4. How FoodLens Works (3-Step Onboarding Guide)
// -------------------------------------------------------------
class _HowItWorksGuide extends StatelessWidget {
  final String language;

  const _HowItWorksGuide({required this.language});

  @override
  Widget build(BuildContext context) {
    final title = DashboardLocalizationHelper.getHowItWorksTitle(language);
    final s1Title = DashboardLocalizationHelper.getStep1(language);
    final s1Desc = DashboardLocalizationHelper.getStep1Desc(language);
    final s2Title = DashboardLocalizationHelper.getStep2(language);
    final s2Desc = DashboardLocalizationHelper.getStep2Desc(language);
    final s3Title = DashboardLocalizationHelper.getStep3(language);
    final s3Desc = DashboardLocalizationHelper.getStep3Desc(language);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline_rounded,
                color: AppColors.tertiary,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _StepCard(
                  stepNumber: '1',
                  icon: Icons.camera_alt_outlined,
                  color: AppColors.primary,
                  title: s1Title,
                  desc: s1Desc,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StepCard(
                  stepNumber: '2',
                  icon: Icons.auto_awesome,
                  color: AppColors.secondary,
                  title: s2Title,
                  desc: s2Desc,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _StepCard(
                  stepNumber: '3',
                  icon: Icons.trending_up_rounded,
                  color: AppColors.accentRose,
                  title: s3Title,
                  desc: s3Desc,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String stepNumber;
  final IconData icon;
  final Color color;
  final String title;
  final String desc;

  const _StepCard({
    required this.stepNumber,
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceHighlight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 9,
              color: AppColors.textMutedDark,
              height: 1.25,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 5. Today's Nutrition Intelligence Dashboard
// -------------------------------------------------------------
class _TodayNutritionSection extends StatelessWidget {
  final DailyLog todayLog;
  final int targetCalories;
  final String language;
  final AppLocalizations l10n;
  final VoidCallback onLogMealTap;
  final void Function(int amount) onAddWater;

  const _TodayNutritionSection({
    required this.todayLog,
    required this.targetCalories,
    required this.language,
    required this.l10n,
    required this.onLogMealTap,
    required this.onAddWater,
  });

  @override
  Widget build(BuildContext context) {
    final consumed = todayLog.totalCalories;
    final remaining = (targetCalories - consumed).clamp(0, 9999);
    final protein = todayLog.totalProtein;
    final carbs = todayLog.totalCarbs;
    final fat = todayLog.totalFat;
    final fiber = todayLog.totalFiber;
    final waterMl = todayLog.waterIntakeMl;

    final insight = DashboardLocalizationHelper.getNutritionInsight(
      language,
      consumed,
      targetCalories,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.todayNutritionSummary,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: onLogMealTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      color: AppColors.primaryLight,
                      size: 14,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      l10n.logMeal,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GlassCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calorie Gauge & Macro Donut Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CalorieGauge(
                        consumedCalories: consumed,
                        targetCalories: targetCalories,
                        size: 140,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.darkSurfaceHighlight,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.darkBorder),
                        ),
                        child: Text(
                          '$remaining ${l10n.kcalLeft}',
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MacroDonutChart(
                        proteinGrams: protein,
                        carbsGrams: carbs,
                        fatGrams: fat,
                        size: 96,
                      ),
                      const SizedBox(height: 8),
                      _MacroLegendRow(
                        color: AppColors.protein,
                        label: l10n.protein,
                        grams: protein,
                      ),
                      _MacroLegendRow(
                        color: AppColors.carbs,
                        label: l10n.carbs,
                        grams: carbs,
                      ),
                      _MacroLegendRow(
                        color: AppColors.fat,
                        label: l10n.fat,
                        grams: fat,
                      ),
                      _MacroLegendRow(
                        color: AppColors.primaryLight,
                        label: l10n.fiber,
                        grams: fiber,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Dynamic Contextual Nutrition Insight
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkSurfaceHighlight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.darkBorder.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.primaryLight,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        insight,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondaryDark,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Divider(color: AppColors.darkBorder),
              const SizedBox(height: 8),

              // Interactive Water Intake Tracker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.water_drop_rounded,
                        color: AppColors.secondary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${l10n.waterHydration}: $waterMl / 2500 ml',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _WaterQuickAddButton(
                        label: '+250 ml',
                        onTap: () => onAddWater(250),
                      ),
                      const SizedBox(width: 6),
                      _WaterQuickAddButton(
                        label: '+500 ml',
                        onTap: () => onAddWater(500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WaterQuickAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _WaterQuickAddButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.secondary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.secondary.withValues(alpha: 0.35),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.secondaryLight,
          ),
        ),
      ),
    );
  }
}

class _MacroLegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final double grams;

  const _MacroLegendRow({
    required this.color,
    required this.label,
    required this.grams,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 10.5,
              color: AppColors.textMutedDark,
            ),
          ),
          Text(
            '${grams.toStringAsFixed(1)}g',
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 6. Personalized AI Food Recommendations Section
// -------------------------------------------------------------
class _AiRecommendationsSection extends StatelessWidget {
  final List<RecommendedDish> recommendations;
  final String language;
  final void Function(RecommendedDish dish) onDishTap;

  const _AiRecommendationsSection({
    required this.recommendations,
    required this.language,
    required this.onDishTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = DashboardLocalizationHelper.getRecommendedTitle(language);
    final sub = DashboardLocalizationHelper.getRecommendedSub(language);
    final badge = DashboardLocalizationHelper.getAiCuratedBadge(language);

    if (recommendations.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  sub,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMutedDark,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.tertiary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: AppColors.tertiary.withValues(alpha: 0.4),
                ),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: AppColors.tertiary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final dish = recommendations[index];
              return _RecommendationCard(
                dish: dish,
                onTap: () => onDishTap(dish),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final RecommendedDish dish;
  final VoidCallback onTap;

  const _RecommendationCard({required this.dish, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final food = dish.food;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodImageView(
              imagePath: food.imagePath,
              foodName: food.foodName,
              height: 90,
              width: double.infinity,
              borderRadius: 10,
            ),
            const SizedBox(height: 8),
            Text(
              food.foodName,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Text(
                  '${food.calories} kcal',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.protein.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${food.protein.toStringAsFixed(0)}g P',
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.protein,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              dish.localizedReason,
              style: const TextStyle(
                fontSize: 9.5,
                color: AppColors.textMutedDark,
                height: 1.25,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 7. Quick-Access Food Intelligence Grid (6 Essential Hubs)
// -------------------------------------------------------------
class _QuickAccessToolsSection extends StatelessWidget {
  final int scansCount;
  final int favoritesCount;
  final String language;
  final AppLocalizations l10n;

  const _QuickAccessToolsSection({
    required this.scansCount,
    required this.favoritesCount,
    required this.language,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final plannerTitle = DashboardLocalizationHelper.getMealPlannerTitle(
      language,
    );
    final plannerSub = DashboardLocalizationHelper.getMealPlannerSub(language);
    final trackerTitle = DashboardLocalizationHelper.getNutritionTrackerTitle(
      language,
    );
    final trackerSub = DashboardLocalizationHelper.getNutritionTrackerSub(
      language,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.foodTools,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        // Row 1: Food Compare & Menu Explorer
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                title: l10n.foodCompare,
                subtitle: l10n.foodCompareSub,
                icon: Icons.compare_arrows_rounded,
                color: AppColors.secondary,
                onTap: () => context.push('/comparison'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionCard(
                title: l10n.menuExplorer,
                subtitle: l10n.menuExplorerSub,
                icon: Icons.menu_book_rounded,
                color: AppColors.tertiary,
                onTap: () => context.push('/menu-explorer'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row 2: AI Meal Planner & Nutrition Tracker
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                title: plannerTitle,
                subtitle: plannerSub,
                icon: Icons.calendar_month_rounded,
                color: AppColors.primary,
                onTap: () => context.push('/meal-plan'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionCard(
                title: trackerTitle,
                subtitle: trackerSub,
                icon: Icons.bar_chart_rounded,
                color: AppColors.accentRose,
                onTap: () => context.push('/tracker'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row 3: Scan History & Favourites
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                title: l10n.scanHistory,
                subtitle: '$scansCount scans',
                icon: Icons.history_rounded,
                color: AppColors.secondaryLight,
                onTap: () => context.push('/history'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionCard(
                title: l10n.favourites,
                subtitle: '$favoritesCount saved',
                icon: Icons.favorite_rounded,
                color: const Color(0xFFF43F5E),
                onTap: () => context.push('/favourites'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      onTap: () {
        HapticHelper.lightImpact();
        onTap();
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: AppColors.textMutedDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// 8. Recent Food Scans Section
// -------------------------------------------------------------
class _RecentScansSection extends StatelessWidget {
  final List<dynamic> history;
  final String language;
  final AppLocalizations l10n;
  final VoidCallback onScanNowTap;
  final void Function(dynamic item) onItemTap;
  final VoidCallback onViewAllTap;

  const _RecentScansSection({
    required this.history,
    required this.language,
    required this.l10n,
    required this.onScanNowTap,
    required this.onItemTap,
    required this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final emptyTitle = DashboardLocalizationHelper.getEmptyScansTitle(language);
    final emptyDesc = DashboardLocalizationHelper.getEmptyScansDesc(language);
    final scanFirstBtn = DashboardLocalizationHelper.getScanFirstMealButton(
      language,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.recentScans,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            if (history.isNotEmpty)
              GestureDetector(
                onTap: onViewAllTap,
                child: Text(
                  l10n.viewAll,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (history.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.darkSurfaceCard,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.primaryLight,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  emptyTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  emptyDesc,
                  style: const TextStyle(
                    color: AppColors.textMutedDark,
                    fontSize: 11,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: onScanNowTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    scanFirstBtn,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 185,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: history.take(6).length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = history[index];
                return _RecentScanCard(
                  item: item,
                  onTap: () => onItemTap(item),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _RecentScanCard extends StatelessWidget {
  final dynamic item;
  final VoidCallback onTap;

  const _RecentScanCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 155,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FoodImageView(
              imagePath: item.imagePath as String?,
              foodName: item.foodName as String?,
              height: 78,
              width: double.infinity,
              borderRadius: 10,
            ),
            const SizedBox(height: 8),
            Text(
              item.foodName as String,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.calories} kcal',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryLight,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${item.healthScore} pts',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
