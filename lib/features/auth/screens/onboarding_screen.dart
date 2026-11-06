import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/dietary_constants.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/custom_button.dart';
import '../providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Scan Any Dish, Menu or Food Label',
      'subtitle':
          'Instant AI food intelligence. Point your camera at home-cooked meals, restaurant menus, or packaged food labels.',
      'icon': Icons.camera_alt_rounded,
      'badge': 'MULTIMODAL VISION',
      'gradient': [Color(0xFF10B981), Color(0xFF059669)],
    },
    {
      'title': 'Deep Nutritional & Health Analytics',
      'subtitle':
          'Get instant calorie estimates, full macronutrient distributions (protein, carbs, fat, fiber), and clinical health grades.',
      'icon': Icons.insights_rounded,
      'badge': 'CLINICAL METRICS',
      'gradient': [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
    },
    {
      'title': 'Personalized Dietary & Allergen Safety',
      'subtitle':
          'Filter by Halal, Vegan, Keto, Gluten-Free, and receive proactive warnings about hidden allergens.',
      'icon': Icons.health_and_safety_rounded,
      'badge': 'SAFETY & GOALS',
      'gradient': [Color(0xFFF59E0B), Color(0xFFD97706)],
    },
    {
      'title': 'Decentralized AI with Puter.js',
      'subtitle':
          'Powered by your personal Puter account. Zero server tracking, full privacy, and a generous free monthly allowance.',
      'icon': Icons.cloud_done_rounded,
      'badge': 'USER-PAYS CLOUD',
      'gradient': [Color(0xFF0055FF), Color(0xFF0033AA)],
    },
  ];

  void _onFinish() async {
    HapticHelper.mediumImpact();
    final storage = ref.read(localStorageServiceProvider);
    await storage.setCompletedOnboarding(true);
    if (!mounted) return;
    context.go('/auth');
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // Header Skip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.center_focus_strong, color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'FoodLens',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ],
                  ),
                  if (_currentPage < _slides.length - 1)
                    TextButton(
                      onPressed: _onFinish,
                      child: const Text('Skip', style: TextStyle(color: AppColors.textMutedDark)),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              // PageView Slides
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (idx) {
                    setState(() => _currentPage = idx);
                    HapticHelper.selectionClick();
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Slide Hero Art / Icon Card
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: slide['gradient'] as List<Color>,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (slide['gradient'] as List<Color>).first.withValues(alpha: 0.4),
                                blurRadius: 40,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            slide['icon'] as IconData,
                            size: 64,
                            color: Colors.white,
                          ),
                        )
                            .animate(key: ValueKey(index))
                            .scale(duration: 500.ms, curve: Curves.easeOutBack)
                            .fadeIn(),
                        const SizedBox(height: 32),
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: (slide['gradient'] as List<Color>).first.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: (slide['gradient'] as List<Color>).first.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            slide['badge'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: (slide['gradient'] as List<Color>).first,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title
                        Text(
                          slide['title'] as String,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        // Subtitle
                        Text(
                          slide['subtitle'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryDark,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // If slide 3 (Preferences), show quick toggle chips
                        if (index == 2) ...[
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            alignment: WrapAlignment.center,
                            children: DietaryConstants.dietaryPreferences.take(6).map((pref) {
                              final isSelected = settings.dietaryFilters.contains(pref);
                              return FilterChip(
                                label: Text(pref),
                                selected: isSelected,
                                onSelected: (_) {
                                  settingsNotifier.toggleDietaryFilter(pref);
                                  HapticHelper.selectionClick();
                                },
                                selectedColor: AppColors.primary.withValues(alpha: 0.25),
                                checkmarkColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.primaryLight : AppColors.textSecondaryDark,
                                ),
                                side: BorderSide(
                                  color: isSelected ? AppColors.primary : AppColors.darkBorder,
                                ),
                                backgroundColor: AppColors.darkSurfaceCard,
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ),
              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_slides.length, (idx) {
                  final isActive = idx == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.darkSurfaceHighlight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 28),
              // Bottom Action Button
              CustomButton(
                text: _currentPage == _slides.length - 1 ? 'Connect Puter Account' : 'Continue',
                icon: _currentPage == _slides.length - 1 ? Icons.arrow_forward_rounded : null,
                onPressed: () {
                  if (_currentPage < _slides.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _onFinish();
                  }
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
