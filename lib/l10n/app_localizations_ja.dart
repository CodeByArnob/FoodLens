// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'FoodLens';

  @override
  String get tagline => 'AI搭載フードインテリジェンス';

  @override
  String get navHome => 'ホーム';

  @override
  String get navTracker => '記録';

  @override
  String get navScanner => 'スキャン';

  @override
  String get navMealPlan => '献立';

  @override
  String get navProfile => 'マイページ';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboardingContinue => '次へ';

  @override
  String get onboardingGetStarted => 'はじめる';

  @override
  String get onboardingTitle1 => '料理、メニュー、栄養表示をスキャン';

  @override
  String get onboardingDesc1 => 'AIによる即時フード分析。手料理やレストランのメニューにカメラを向けるだけ。';

  @override
  String get onboardingTitle2 => '詳細な栄養＆ヘルススコア分析';

  @override
  String get onboardingDesc2 => 'カロリー、PFCバランス（タンパク質・糖質・脂質・食物繊維）を瞬時に算出。';

  @override
  String get onboardingTitle3 => 'パーソナライズされた食事＆アレルゲン管理';

  @override
  String get onboardingDesc3 => 'ハラール、ヴィーガン、ケトなどの設定とアレルゲン警告。';

  @override
  String get onboardingTitle4 => 'Puter.jsによる分散型プライベートAI';

  @override
  String get onboardingDesc4 => '個人のPuterアカウントを活用し、完全なプライバシーと毎月の無料枠を提供。';

  @override
  String get connectPuterTitle => 'Puterアカウント連携';

  @override
  String get connectPuterSub => 'パーソナルAIフードクラウド';

  @override
  String get connectPuterDesc => 'FoodLensはPuter.jsのUser-Paysアーキテクチャを採用しています。';

  @override
  String get signInWithPuter => 'Puterでサインイン';

  @override
  String get createFreePuterAccount => 'Puter無料アカウント作成';

  @override
  String get offlineMode => 'オフラインモード';

  @override
  String get signInWithToken => 'APIトークンでサインイン';

  @override
  String get hideTokenLogin => 'トークン入力を隠す';

  @override
  String get tokenPlaceholder => 'puter.com/dashboard からトークンを貼り付け';

  @override
  String get connectWithToken => 'トークンで接続';

  @override
  String get paste => '貼り付け';

  @override
  String get getToken => 'トークン取得 ↗';

  @override
  String get greeting => 'こんにちは、フードエクスプローラー 👋';

  @override
  String get greetingSub => '日々の食事と栄養バランスを管理しましょう';

  @override
  String get todayNutritionSummary => '本日の栄養サマリー';

  @override
  String get kcalConsumed => 'kcal 摂取済み';

  @override
  String get kcalLeft => '残り';

  @override
  String get protein => 'タンパク質';

  @override
  String get carbs => '炭水化物';

  @override
  String get fat => '脂質';

  @override
  String get fiber => '食物繊維';

  @override
  String get waterHydration => '水分補給';

  @override
  String get addWater => '+250 ml 水分';

  @override
  String get foodTools => 'フードインテリジェンス機能';

  @override
  String get foodCompare => '料理を比較';

  @override
  String get foodCompareSub => '並べて栄養を比較';

  @override
  String get menuExplorer => 'メニュー分析';

  @override
  String get menuExplorerSub => '外食メニューを解析';

  @override
  String get scanHistory => 'スキャン履歴';

  @override
  String get favourites => 'お気に入り';

  @override
  String scansCount(int count) {
    return '$count 回スキャン';
  }

  @override
  String savedCount(int count) {
    return '$count 件保存';
  }

  @override
  String get recommendedForGoals => '目標に合わせたおすすめ料理';

  @override
  String get viewAll => 'すべて表示';

  @override
  String get dishMode => '料理';

  @override
  String get menuMode => 'メニュー';

  @override
  String get labelMode => '成分表示';

  @override
  String get alignFoodPrompt => 'お皿をフレームの中央に合わせてください';

  @override
  String get alignMenuPrompt => 'メニュー表の文字に向けてください';

  @override
  String get alignLabelPrompt => 'パッケージの栄養成分表示表に合わせてください';

  @override
  String get takePhoto => '撮影する';

  @override
  String get uploadGallery => 'アルバムから選択';

  @override
  String get analyzingFood => 'フードインテリジェンス解析中...';

  @override
  String get healthIndex => 'ヘルススコア';

  @override
  String get score => 'スコア';

  @override
  String get aiEstimate => 'AI推定';

  @override
  String get verifiedLabel => '認証ラベル';

  @override
  String get macroBreakdown => 'マクロ栄養素の内訳';

  @override
  String get microBreakdown => 'ビタミン＆微量栄養素';

  @override
  String get sugar => '糖質';

  @override
  String get saturatedFat => '飽和脂肪酸';

  @override
  String get sodium => 'ナトリウム';

  @override
  String get potassium => 'カリウム';

  @override
  String get calcium => 'カルシウム';

  @override
  String get iron => '鉄分';

  @override
  String get vitaminC => 'ビタミンC';

  @override
  String get ingredients => '主な原材料';

  @override
  String get healthierAlternatives => 'より健康的な選択肢';

  @override
  String get portionSize => '分量';

  @override
  String get logMeal => '食事を記録';

  @override
  String get originalPrice => '元の価格';

  @override
  String get convertedPrice => '換算価格';

  @override
  String exchangeRateSource(String source) {
    return '$source による為替レート更新';
  }

  @override
  String get menuExplorerTitle => 'レストランメニュー探検';

  @override
  String get scanPhysicalMenu => '紙のメニューをスキャン';

  @override
  String get scanMenuDesc => '紙のメニュー表から料理名や栄養価を読み取ります。';

  @override
  String get scanMenuBtn => 'カメラでメニューをスキャン';

  @override
  String get curatedDemos => 'おすすめサンプルメニュー';

  @override
  String get detectedDishes => '検出された料理＆栄養素';

  @override
  String get allItems => 'すべての料理';

  @override
  String get highProtein => '高タンパク (25g+)';

  @override
  String get lowCalorie => '低カロリー (<500 kcal)';

  @override
  String get settingsTitle => '設定と詳細設定';

  @override
  String get appearanceSection => '外観とテーマ';

  @override
  String get appearanceDesc => 'ダークモードやテーマカラーの切り替え';

  @override
  String get themeMode => 'テーマ設定';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get systemDefault => 'システム標準';

  @override
  String get languageRegionSection => '言語と地域';

  @override
  String get languageRegionDesc => 'アプリの表示言語と国・書式設定';

  @override
  String get language => '表示言語';

  @override
  String get countryRegion => '国 / 地域';

  @override
  String get timeZone => 'タイムゾーン';

  @override
  String get currencyLocalizationSection => '通貨と価格表示';

  @override
  String get currencyLocalizationDesc => 'リアルタイム為替レートによる価格換算';

  @override
  String get currency => '利用通貨';

  @override
  String get exchangeRates => 'リアルタイム為替レート';

  @override
  String get measurementSystemSection => '単位系';

  @override
  String get measurementSystemDesc => 'メートル法（グラム、ml）とヤード・ポンド法（オンス）';

  @override
  String get unitSystem => '単位システム';

  @override
  String get metric => 'メートル法（g, ml, kg）';

  @override
  String get imperial => 'ヤード・ポンド法（oz, fl oz, lb）';

  @override
  String get dietaryPreferencesSection => '食事の好みと制限';

  @override
  String get dietaryPreferencesDesc => 'ハラール、ヴィーガン、ケト、アレルゲン除外';

  @override
  String get dailyCalorieGoal => '1日の目標カロリー';

  @override
  String get notificationsSection => '通知設定';

  @override
  String get notificationsDesc => '食事記録や水分補給のリマインダー';

  @override
  String get hydrationReminders => '水分補給リマインダー';

  @override
  String get mealReminders => '食事記録リマインダー';

  @override
  String get privacySecuritySection => 'プライバシーとセキュリティ';

  @override
  String get privacySecurityDesc => 'Puterキーとデータ管理';

  @override
  String get puterAccount => 'Puter.jsアカウント';

  @override
  String get connected => '接続済み';

  @override
  String get disconnected => '未接続（オフライン）';

  @override
  String get storageDataSection => 'ストレージとデータ';

  @override
  String get storageDataDesc => 'ローカルキャッシュと保存データの管理';

  @override
  String get clearCache => 'ローカルキャッシュを消去';

  @override
  String get cacheCleared => 'キャッシュを正常に消去しました。';

  @override
  String get aboutSection => 'FoodLensについて';

  @override
  String get aboutDesc => '開発者プロフィール、クレジット情報、バージョン';

  @override
  String get aboutTitle => 'FoodLensについて';

  @override
  String get appName => 'FoodLens';

  @override
  String get appVersion => 'バージョン 1.0.0 (グローバルリリース)';

  @override
  String get creatorTitle => '企画・開発';

  @override
  String get developerName => 'CodeByArnob';

  @override
  String get developerRole => '原作者・リードエンジニア';

  @override
  String get viewGithubProfile => 'GitHubプロフィールを表示';

  @override
  String get madeWithPassion => 'Made with passion by CodeByArnob ❤️';

  @override
  String get maintainerTitle => 'プロジェクト管理者';

  @override
  String get contributorsTitle => 'コントリビューター＆オープンソース';

  @override
  String get officialGithub => '公式GitHubリポジトリ';

  @override
  String get safetyDisclaimerTitle => '健康・栄養免責事項';

  @override
  String get safetyDisclaimer =>
      'FoodLensの栄養推定は画像解析に基づきます。アレルゲンの完全な非混入を保証するものではなく、医療上の助言ではありません。';

  @override
  String get insufficientFundsTitle => '月間利用枠の上限に達しました';

  @override
  String get insufficientFundsDesc =>
      'Puter AIの今月の無料枠を使い切りました。アカウントのアップグレードを行ってください。';

  @override
  String get upgradePuter => 'Puterアカウントをアップグレード';

  @override
  String get aboutFoodLens => 'FoodLensについて';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get suggestedLocale => 'おすすめの言語';

  @override
  String get selectCurrency => '通貨を選択';

  @override
  String get localizationSection => '地域と言語設定';

  @override
  String get measurementSystem => '単位系';

  @override
  String get dietarySection => '食事設定と目標';

  @override
  String get dietaryFilters => '食事フィルター';

  @override
  String get dataManagement => 'ストレージとデータ';

  @override
  String get cancel => 'キャンセル';

  @override
  String get clear => 'クリア';

  @override
  String get recentScans => '最近のスキャン';

  @override
  String get favorites => 'お気に入り';
}
