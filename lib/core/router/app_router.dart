import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/auth/screens/puter_auth_screen.dart';
import '../../features/auth/screens/puter_auth_webview_screen.dart';
import '../../features/auth/screens/puter_usage_screen.dart';
import '../../features/dashboard/screens/main_shell_screen.dart';
import '../../features/dashboard/screens/home_dashboard_screen.dart';
import '../../features/scanner/screens/scanner_screen.dart';
import '../../features/scanner/screens/food_analysis_screen.dart';
import '../../features/scanner/screens/menu_analysis_screen.dart';
import '../../features/scanner/models/food_analysis_result.dart';
import '../../features/scanner/models/menu_analysis_result.dart';
import '../../features/nutrition_tracking/screens/nutrition_tracker_screen.dart';
import '../../features/meal_planner/screens/meal_planner_screen.dart';
import '../../features/comparison/screens/food_comparison_screen.dart';
import '../../features/history_favorites/screens/favourites_screen.dart';
import '../../features/history_favorites/screens/scan_history_screen.dart';
import '../../features/menu_explorer/screens/menu_explorer_screen.dart';
import '../../features/settings/screens/profile_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/help_center_screen.dart';
import '../../features/settings/screens/privacy_policy_screen.dart';
import '../../features/settings/screens/terms_screen.dart';
import '../../features/settings/screens/about_screen.dart';
import '../../features/settings/screens/error_dialog_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  errorBuilder: (context, state) => CustomErrorScreen(
    errorMessage: state.error?.toString(),
  ),
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const PuterAuthScreen(),
    ),
    GoRoute(
      path: '/puter-webview-auth',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final mode = state.uri.queryParameters['mode'] ?? 'login';
        return PuterAuthWebViewScreen(mode: mode);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShellScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeDashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tracker',
              builder: (context, state) => const NutritionTrackerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/meal-plan',
              builder: (context, state) => const MealPlannerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/scanner',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ScannerScreen(),
    ),
    GoRoute(
      path: '/analysis-result',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final result = state.extra as FoodAnalysisResult?;
        return FoodAnalysisScreen(passedResult: result);
      },
    ),
    GoRoute(
      path: '/menu-analysis',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final result = state.extra as MenuAnalysisResult?;
        return MenuAnalysisScreen(passedResult: result);
      },
    ),
    GoRoute(
      path: '/comparison',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FoodComparisonScreen(),
    ),
    GoRoute(
      path: '/menu-explorer',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MenuExplorerScreen(),
    ),
    GoRoute(
      path: '/favourites',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FavouritesScreen(),
    ),
    GoRoute(
      path: '/history',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ScanHistoryScreen(),
    ),
    GoRoute(
      path: '/usage',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PuterUsageScreen(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/help',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const HelpCenterScreen(),
    ),
    GoRoute(
      path: '/privacy',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: '/terms',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TermsScreen(),
    ),
    GoRoute(
      path: '/about',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);
