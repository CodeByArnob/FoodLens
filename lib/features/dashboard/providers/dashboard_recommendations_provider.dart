import 'package:flutter_riverpod/legacy.dart';
import '../../scanner/models/food_analysis_result.dart';
import '../../../shared/services/local_storage_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../../settings/providers/settings_provider.dart';

class RecommendedDish {
  final FoodAnalysisResult food;
  final String localizedReason;

  const RecommendedDish({required this.food, required this.localizedReason});
}

final dashboardRecommendationsProvider =
    StateNotifierProvider<
      DashboardRecommendationsNotifier,
      List<RecommendedDish>
    >((ref) {
      final storage = ref.watch(localStorageServiceProvider);
      final settings = ref.watch(settingsProvider);
      return DashboardRecommendationsNotifier(storage, settings.language);
    });

class DashboardRecommendationsNotifier
    extends StateNotifier<List<RecommendedDish>> {
  final LocalStorageService _storage;
  final String _lang;

  DashboardRecommendationsNotifier(this._storage, this._lang)
    : super(const []) {
    loadRecommendations();
  }

  Future<void> loadRecommendations() async {
    final list = await _storage.loadSeedDatabase();
    if (list.isEmpty) return;

    final recommended = list.map((food) {
      return RecommendedDish(
        food: food,
        localizedReason: _getLocalizedReason(food.foodName, _lang),
      );
    }).toList();

    state = recommended;
  }

  String _getLocalizedReason(String foodName, String lang) {
    final lower = foodName.toLowerCase();

    if (lower.contains('salmon') || lower.contains('fish')) {
      switch (lang) {
        case 'bn':
          return '৩৮ গ্রাম প্রোটিন ও ওমেগা-৩ সমৃদ্ধ খাবার, যা আপনার পুষ্টির লক্ষ্য পূরণ করবে।';
        case 'ar':
          return 'غني بـ 38 جم بروتين وأوميغا 3 أساسي لتحقيق هدفك اليومي.';
        case 'es':
          return 'Con 38g de proteína y Omega-3 esencial para tus metas.';
        case 'fr':
          return 'Riche en 38g de protéines et oméga-3 essentiels pour vos objectifs.';
        case 'de':
          return 'Reich an 38g Protein und Omega-3-Fettsäuren für dein Tagesziel.';
        case 'hi':
          return '38 ग्राम प्रोटीन और ओमेगा-3 से भरपूर जो दैनिक लक्ष्य पूरा करता है।';
        case 'ja':
          return '38gの高タンパク質と必須オメガ3で本日の目標を強力サポート。';
        case 'en':
        default:
          return 'Packed with 38g protein & essential Omega-3s to hit your daily target.';
      }
    } else if (lower.contains('avocado') || lower.contains('egg')) {
      switch (lang) {
        case 'bn':
          return 'হৃদযন্ত্রের জন্য উপকারী ফ্যাট ও উচ্চমানের প্রোটিন সমৃদ্ধ খাবার।';
        case 'ar':
          return 'دهون أحادية صحية للقلب وبروتين بيولوجي عالي القيمة.';
        case 'es':
          return 'Grasas monoinsaturadas saludables y colina de alta biodisponibilidad.';
        case 'fr':
          return 'Graisses saines et choline à haute biodisponibilité.';
        case 'de':
          return 'Herzgesunde Fette und hochverwertbares Cholin für deinen Tag.';
        case 'hi':
          return 'हृदय के लिए स्वस्थ वसा और उच्च गुणवत्ता वाले प्रोटीन से भरपूर।';
        case 'ja':
          return '心臓に優しい不飽和脂肪酸と高吸収コリンで持続的なエネルギー補給。';
        case 'en':
        default:
          return 'Heart-healthy monounsaturated fats & high-bioavailability choline.';
      }
    } else if (lower.contains('greek') ||
        lower.contains('salad') ||
        lower.contains('chicken')) {
      switch (lang) {
        case 'bn':
          return '৩৪ গ্রাম লীন প্রোটিন ও মাত্র ১৪ গ্রাম কার্বস সমৃদ্ধ লো-কার্ব খাবার।';
        case 'ar':
          return '34 جم بروتين نقي مع كربوهيدرات منخفضة (14 جم) وفيتامينات حيوية.';
        case 'es':
          return '34g de proteína magra con solo 14g de carbohidratos y vegetales frescos.';
        case 'fr':
          return '34g de protéines maigres pour seulement 14g de glucides.';
        case 'de':
          return '34g mageres Geflügelprotein bei nur 14g Kohlenhydraten.';
        case 'hi':
          return '34 ग्राम लीन प्रोटीन और केवल 14 ग्राम कार्ब्स के साथ संतुलित आहार।';
        case 'ja':
          return 'わずか14gの低糖質と34gの良質な赤身チキンタンパク質。';
        case 'en':
        default:
          return 'Lean 34g poultry protein with low carbs (14g) and crisp micronutrients.';
      }
    } else if (lower.contains('lentil') ||
        lower.contains('dahl') ||
        lower.contains('spinach')) {
      switch (lang) {
        case 'bn':
          return '১১.৫ গ্রাম ফাইবার, আয়রন ও অ্যান্টিঅক্সিডেন্ট সমৃদ্ধ স্বাস্থ্যকর ডাল।';
        case 'ar':
          return '11.5 جم ألياف بريبيوتيك مع حديد نباتي وصفر كوليسترول.';
        case 'es':
          return '11.5g de fibra prebiótica con hierro vegetal y sin colesterol.';
        case 'fr':
          return '11.5g de fibres prébiotiques avec fer végétal et zéro cholestérol.';
        case 'de':
          return '11.5g präbiotische Ballaststoffe, pflanzliches Eisen und 0% Cholesterin.';
        case 'hi':
          return '11.5 ग्राम फाइबर, प्लांट-बेस्ड आयरन और शून्य कोलेस्ट्रॉल युक्त।';
        case 'ja':
          return '11.5gのプレバイオティクス食物繊維と植物性鉄分、コレステロールゼロ。';
        case 'en':
        default:
          return '11.5g prebiotic fiber powerhouse with plant-based iron and zero cholesterol.';
      }
    } else {
      switch (lang) {
        case 'bn':
          return '১৮ গ্রাম প্রোটিন ও লাইকোপেন সমৃদ্ধ সুস্বাদু খাবার।';
        case 'ar':
          return 'طبق متوازن مع 18 جم بروتين ومضادات أكسدة طبيعية.';
        case 'es':
          return 'Delicioso clásico con 18g de proteína y licopeno antioxidante.';
        case 'fr':
          return 'Classique savoureux avec 18g de protéines et antioxydants lycopène.';
        case 'de':
          return 'Schmackhafter Klassiker mit 18g Protein und wertvollem Lycopin.';
        case 'hi':
          return '18 ग्राम प्रोटीन और एंटीऑक्सीडेंट से युक्त स्वादिष्ट भोजन।';
        case 'ja':
          return '18gのタンパク質と抗酸化リコピンを含むバランスの良い一皿。';
        case 'en':
        default:
          return 'Satisfying meal with 18g protein and natural lycopene antioxidants.';
      }
    }
  }
}
