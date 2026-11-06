import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodlens/main.dart';
import 'package:foodlens/shared/services/local_storage_service.dart';
import 'package:foodlens/features/auth/providers/auth_provider.dart';
import 'package:foodlens/shared/widgets/calorie_gauge.dart';
import 'package:foodlens/shared/widgets/health_score_indicator.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'foodlens_onboarding_completed': true,
      'foodlens_daily_calorie_target': 2200,
    });
  });

  testWidgets('CalorieGauge widget renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CalorieGauge(
              consumedCalories: 650,
              targetCalories: 2000,
            ),
          ),
        ),
      ),
    );

    expect(find.text('650'), findsOneWidget);
    expect(find.text('kcal consumed'), findsOneWidget);
    expect(find.text('1350 left'), findsOneWidget);
  });

  testWidgets('HealthScoreIndicator displays score and verified badge', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: HealthScoreIndicator(
              score: 92,
              confidenceScore: 0.98,
              isVerified: true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('92'), findsOneWidget);
    expect(find.text('SCORE'), findsOneWidget);
    expect(find.text('VERIFIED LABEL'), findsOneWidget);
    expect(find.textContaining('Grade A+'), findsOneWidget);
  });

  testWidgets('FoodLensApp boots up and renders root splash screen', (WidgetTester tester) async {
    final prefs = await SharedPreferences.getInstance();
    final storageService = LocalStorageService(prefs);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageServiceProvider.overrideWithValue(storageService),
        ],
        child: const FoodLensApp(),
      ),
    );

    await tester.pump();
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Lens'), findsOneWidget);

    // Flush splash screen timer
    await tester.pump(const Duration(milliseconds: 3000));
  });
}
