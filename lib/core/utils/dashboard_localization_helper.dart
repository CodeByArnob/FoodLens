/// Multilingual localization helper for FoodLens Home Dashboard.
/// Supports English (en), Bengali (bn), Arabic (ar), Spanish (es),
/// French (fr), German (de), Hindi (hi), and Japanese (ja).
class DashboardLocalizationHelper {
  /// Contextual time-of-day greeting
  static String getGreeting(String lang, String? userName, {int? hour}) {
    final currentHour = hour ?? DateTime.now().hour;
    final name = (userName != null && userName.isNotEmpty) ? userName : _getDefaultUserTitle(lang);

    if (currentHour >= 5 && currentHour < 12) {
      switch (lang) {
        case 'bn':
          return 'সুপ্রভাত, $name ☀️';
        case 'ar':
          return 'صباح الخير، $name ☀️';
        case 'es':
          return '¡Buenos días, $name! ☀️';
        case 'fr':
          return 'Bonjour, $name ☀️';
        case 'de':
          return 'Guten Morgen, $name ☀️';
        case 'hi':
          return 'सुप्रभात, $name ☀️';
        case 'ja':
          return 'おはようございます、$nameさん ☀️';
        case 'en':
        default:
          return 'Good morning, $name ☀️';
      }
    } else if (currentHour >= 12 && currentHour < 17) {
      switch (lang) {
        case 'bn':
          return 'শুভ অপরাহ্ন, $name 🌤️';
        case 'ar':
          return 'مساء الخير، $name 🌤️';
        case 'es':
          return '¡Buenas tardes, $name! 🌤️';
        case 'fr':
          return 'Bon après-midi, $name 🌤️';
        case 'de':
          return 'Guten Tag, $name 🌤️';
        case 'hi':
          return 'शुभ दोपहर, $name 🌤️';
        case 'ja':
          return 'こんにちは、$nameさん 🌤️';
        case 'en':
        default:
          return 'Good afternoon, $name 🌤️';
      }
    } else {
      switch (lang) {
        case 'bn':
          return 'শুভ সন্ধ্যা, $name 🌙';
        case 'ar':
          return 'مساء النور، $name 🌙';
        case 'es':
          return '¡Buenas noches, $name! 🌙';
        case 'fr':
          return 'Bonsoir, $name 🌙';
        case 'de':
          return 'Guten Abend, $name 🌙';
        case 'hi':
          return 'शुभ संध्या, $name 🌙';
        case 'ja':
          return 'こんばんは、$nameさん 🌙';
        case 'en':
        default:
          return 'Good evening, $name 🌙';
      }
    }
  }

  static String _getDefaultUserTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'ফুড এক্সপ্লোরার';
      case 'ar':
        return 'مستكشف الطعام';
      case 'es':
        return 'Explorador';
      case 'fr':
        return 'Gourmet';
      case 'de':
        return 'Feinschmecker';
      case 'hi':
        return 'फूड एक्सप्लोरर';
      case 'ja':
        return '美食家';
      case 'en':
      default:
        return 'Food Explorer';
    }
  }

  static String getTagline(String lang) {
    switch (lang) {
      case 'bn':
        return 'স্মার্ট এআই পুষ্টি ও খাদ্য বিশ্লেষণ';
      case 'ar':
        return 'ذكاء اصطناعي لتحليل الوجبات والتغذية';
      case 'es':
        return 'Inteligencia nutricional impulsada por IA';
      case 'fr':
        return 'Intelligence nutritionnelle par IA';
      case 'de':
        return 'KI-gestützte Ernährungsintelligenz';
      case 'hi':
        return 'एआई-संचालित पोषण एवं आहार विश्लेषण';
      case 'ja':
        return 'AI駆動のスマート栄養インテリジェンス';
      case 'en':
      default:
        return 'AI-Powered Nutrition & Dietary Intelligence';
    }
  }

  // Primary Action 1: Scan Food Dish
  static String getScanFoodTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'খাবারের ছবি স্ক্যান করুন';
      case 'ar':
        return 'مسح وجبة طعام';
      case 'es':
        return 'Escanear plato de comida';
      case 'fr':
        return 'Scanner un plat cuisiné';
      case 'de':
        return 'Mahlzeit scannen';
      case 'hi':
        return 'भोजन की थाली स्कैन करें';
      case 'ja':
        return '料理をスキャン';
      case 'en':
      default:
        return 'Scan Food Dish';
    }
  }

  static String getScanFoodSub(String lang) {
    switch (lang) {
      case 'bn':
        return 'ক্যালোরি, প্রোটিন, কার্বস ও স্বাস্থ্যমান এক নিমিষে জানুন';
      case 'ar':
        return 'سعرات، بروتين، كربوهيدرات وتقييم صحي فوري عبر الذكاء الاصطناعي';
      case 'es':
        return 'Calorías, macros y puntuación de salud instantánea con IA';
      case 'fr':
        return 'Calories, macronutriments et score santé instantanés par IA';
      case 'de':
        return 'Sofortige Kalorien, Makros & Gesundheitswerte mit Puter KI';
      case 'hi':
        return 'एआई द्वारा कैलोरी, प्रोटीन व पोषक तत्वों की त्वरित गणना';
      case 'ja':
        return 'Puter AIがカロリー、PFCバランス、健康度を瞬時に解析';
      case 'en':
      default:
        return 'Instant calories, macros, ingredients & health score with Puter AI';
    }
  }

  static String getCaptureCamera(String lang) {
    switch (lang) {
      case 'bn':
        return 'ক্যামেরা';
      case 'ar':
        return 'الكاميرا';
      case 'es':
        return 'Cámara';
      case 'fr':
        return 'Caméra';
      case 'de':
        return 'Kamera';
      case 'hi':
        return 'कैमरा';
      case 'ja':
        return 'カメラ';
      case 'en':
      default:
        return 'Camera';
    }
  }

  static String getUploadGallery(String lang) {
    switch (lang) {
      case 'bn':
        return 'গ্যালারি';
      case 'ar':
        return 'المعرض';
      case 'es':
        return 'Galería';
      case 'fr':
        return 'Galerie';
      case 'de':
        return 'Galerie';
      case 'hi':
        return 'गैलरी';
      case 'ja':
        return 'ギャラリー';
      case 'en':
      default:
        return 'Gallery';
    }
  }

  // Primary Action 2: Scan Restaurant Menu
  static String getScanMenuTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'রেস্তোরাঁর মেনু স্ক্যান';
      case 'ar':
        return 'مسح قائمة المطعم';
      case 'es':
        return 'Escanear menú físico';
      case 'fr':
        return 'Scanner le menu';
      case 'de':
        return 'Speisekarte scannen';
      case 'hi':
        return 'रेस्टोरेंट मेनू स्कैन करें';
      case 'ja':
        return 'メニュー表をスキャン';
      case 'en':
      default:
        return 'Scan Restaurant Menu';
    }
  }

  static String getScanMenuSub(String lang) {
    switch (lang) {
      case 'bn':
        return 'কাগজের মেনু থেকে খাবার, দাম ও পুষ্টিমান সরাসরি বের করুন';
      case 'ar':
        return 'استخراج الأطباق والأسعار والتقييم الصحي من القوائم المطبوعة';
      case 'es':
        return 'Extrae platos, precios y salud dietética de menús de papel';
      case 'fr':
        return 'Extrayez plats, prix et scores santé des cartes papier';
      case 'de':
        return 'Erkenne Gerichte, Preise & Nährwerte aus gedruckten Speisekarten';
      case 'hi':
        return 'कागजी मेनू से व्यंजन, कीमतें और स्वास्थ्य स्कोर तुरंत निकालें';
      case 'ja':
        return '紙のメニューから料理、価格、健康スコアを自動抽出';
      case 'en':
      default:
        return 'Extract dishes, prices & dietary health ratings from paper menus';
    }
  }

  static String getScanMenuButton(String lang) {
    switch (lang) {
      case 'bn':
        return 'মেনু স্ক্যান শুরু করুন ➔';
      case 'ar':
        return 'بدء مسح القائمة ➔';
      case 'es':
        return 'Escanear menú ➔';
      case 'fr':
        return 'Scanner le menu ➔';
      case 'de':
        return 'Menü scannen ➔';
      case 'hi':
        return 'मेनू स्कैन करें ➔';
      case 'ja':
        return 'メニューを読み取る ➔';
      case 'en':
      default:
        return 'Start Menu Scan ➔';
    }
  }

  // Recommendations section
  static String getRecommendedTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'আপনার জন্য প্রস্তাবিত খাবার';
      case 'ar':
        return 'وجبات مقترحة خصيصاً لك';
      case 'es':
        return 'Recomendado para ti';
      case 'fr':
        return 'Recommandé pour vous';
      case 'de':
        return 'Für dich empfohlen';
      case 'hi':
        return 'आपके लिए अनुशंसित आहार';
      case 'ja':
        return 'あなたへのおすすめ料理';
      case 'en':
      default:
        return 'Personalized For You';
    }
  }

  static String getRecommendedSub(String lang) {
    switch (lang) {
      case 'bn':
        return 'আপনার বাকি থাকা প্রোটিন ও স্বাস্থ্য লক্ষ্য পূরণে কিউরেটেড';
      case 'ar':
        return 'مختارة بعناية لتغطية ما تبقى من أهدافك الغذائية لليوم';
      case 'es':
        return 'Basado en tus macros restantes y metas diarias';
      case 'fr':
        return 'Calculé pour combler vos macros restantes du jour';
      case 'de':
        return 'Ausgewählt passend zu deinen verbleibenden Makronährstoffen';
      case 'hi':
        return 'आपके शेष मैक्रोज़ और स्वास्थ्य लक्ष्यों को पूरा करने हेतु';
      case 'ja':
        return '本日の残りカロリーとタンパク質目標に合わせて厳選';
      case 'en':
      default:
        return 'Targeted to replenish your remaining macros & daily goals';
    }
  }

  static String getAiCuratedBadge(String lang) {
    switch (lang) {
      case 'bn':
        return 'এআই কিউরেটেড';
      case 'ar':
        return 'مختارة بالذكاء';
      case 'es':
        return 'CURADO POR IA';
      case 'fr':
        return 'SÉLECTION IA';
      case 'de':
        return 'KI-KURATIERT';
      case 'hi':
        return 'एआई चयनित';
      case 'ja':
        return 'AI厳選';
      case 'en':
      default:
        return 'AI CURATED';
    }
  }

  // How it works
  static String getHowItWorksTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'ফুডলেন্স যেভাবে কাজ করে';
      case 'ar':
        return 'كيف يعمل تطبيق FoodLens';
      case 'es':
        return 'Cómo funciona FoodLens';
      case 'fr':
        return 'Comment fonctionne FoodLens';
      case 'de':
        return 'So funktioniert FoodLens';
      case 'hi':
        return 'FoodLens कैसे काम करता है';
      case 'ja':
        return 'FoodLensの使い方';
      case 'en':
      default:
        return 'How FoodLens Works';
    }
  }

  static String getStep1(String lang) {
    switch (lang) {
      case 'bn':
        return '১. খাবারের ছবি তুলুন';
      case 'ar':
        return '١. صوّر الوجبة';
      case 'es':
        return '1. Captura tu plato';
      case 'fr':
        return '1. Photographiez le plat';
      case 'de':
        return '1. Mahlzeit fotografieren';
      case 'hi':
        return '१. भोजन की फोटो लें';
      case 'ja':
        return '1. 料理をカメラで撮影';
      case 'en':
      default:
        return '1. Snap Meal or Menu';
    }
  }

  static String getStep1Desc(String lang) {
    switch (lang) {
      case 'bn':
        return 'যেকোনো থালা বা মেনুর ওপর ক্যামেরা তাক করুন';
      case 'ar':
        return 'وجّه الكاميرا نحو أي طبق طعام أو قائمة ورقية';
      case 'es':
        return 'Apunta a cualquier plato o menú impreso';
      case 'fr':
        return 'Cadrez n\'importe quelle assiette ou menu papier';
      case 'de':
        return 'Richte die Kamera auf ein Gericht oder eine Karte';
      case 'hi':
        return 'किसी भी थाली या मेनू कार्ड पर कैमरा केंद्रित करें';
      case 'ja':
        return 'お皿や紙のメニューにカメラを向けるだけ';
      case 'en':
      default:
        return 'Point camera at any homemade plate or menu';
    }
  }

  static String getStep2(String lang) {
    switch (lang) {
      case 'bn':
        return '২. এআই ভিশন বিশ্লেষণ';
      case 'ar':
        return '٢. تحليل الرؤية الذكي';
      case 'es':
        return '2. Análisis con visión IA';
      case 'fr':
        return '2. Analyse par vision IA';
      case 'de':
        return '2. KI-Tiefenanalyse';
      case 'hi':
        return '२. एआई विज़न विश्लेषण';
      case 'ja':
        return '2. AIビジョン瞬間解析';
      case 'en':
      default:
        return '2. Deep AI Vision';
    }
  }

  static String getStep2Desc(String lang) {
    switch (lang) {
      case 'bn':
        return 'ক্যালোরি, প্রোটিন ও উপাদানের সঠিক পরিমাপ';
      case 'ar':
        return 'حساب دقيق للسعرات والبروتين والمكونات';
      case 'es':
        return 'Cálculo preciso de calorías, proteínas y alérgenos';
      case 'fr':
        return 'Calcul précis des calories, protéines et allergènes';
      case 'de':
        return 'Präzise Berechnung von Kalorien, Makros & Allergenen';
      case 'hi':
        return 'कैलोरी, प्रोटीन और एलर्जेंस की सटीक पहचान';
      case 'ja':
        return 'カロリー、PFC、アレルゲンを正確に算出';
      case 'en':
      default:
        return 'Puter AI calculates calories, macros & ingredients';
    }
  }

  static String getStep3(String lang) {
    switch (lang) {
      case 'bn':
        return '৩. লক্ষ্য ও স্বাস্থ্যরক্ষা';
      case 'ar':
        return '٣. تتبع وحقق أهدافك';
      case 'es':
        return '3. Logra tus metas';
      case 'fr':
        return '3. Atteignez vos objectifs';
      case 'de':
        return '3. Ziele verwirklichen';
      case 'hi':
        return '३. लक्ष्य ट्रैक व पूरे करें';
      case 'ja':
        return '3. 目標達成と健康管理';
      case 'en':
      default:
        return '3. Track & Optimize';
    }
  }

  static String getStep3Desc(String lang) {
    switch (lang) {
      case 'bn':
        return 'দৈনিক লগ রাখুন ও স্বাস্থ্যকর বিকল্প বেছে নিন';
      case 'ar':
        return 'سجّل تغذيتك واختر البدائل الصحية الذكية';
      case 'es':
        return 'Registra tu ingesta y descubre alternativas sanas';
      case 'fr':
        return 'Consignez vos repas et trouvez des alternatives saines';
      case 'de':
        return 'Tagebuch führen & gesündere Alternativen finden';
      case 'hi':
        return 'दैनिक डाइट डायरी रखें और स्वस्थ विकल्प चुनें';
      case 'ja':
        return '日々の食事を記録し、より健康的な選択肢を発見';
      case 'en':
      default:
        return 'Log nutrients, stay hydrated and pick healthier foods';
    }
  }

  // Nutrition explanations
  static String getNutritionInsight(String lang, int consumed, int target) {
    final diff = target - consumed;

    if (consumed == 0) {
      switch (lang) {
        case 'bn':
          return 'সকালের নাস্তার ছবি স্ক্যান করে আজ আপনার প্রথম পুষ্টি লগ তৈরি করুন।';
        case 'ar':
          return 'ابدأ يومك بتسجيل وجبة الإفطار لتتبع أهدافك بدقة.';
        case 'es':
          return 'Comienza registrando tu desayuno para mantenerte en el objetivo.';
        case 'fr':
          return 'Commencez par enregistrer votre petit-déjeuner pour garder le cap.';
        case 'de':
          return 'Starte deinen Tag mit dem Scannen deines Frühstücks.';
        case 'hi':
          return 'अपने लक्ष्यों पर बने रहने के लिए नाश्ते की फोटो स्कैन करके दिन शुरू करें।';
        case 'ja':
          return '朝食をスキャンして、本日のスマート栄養記録をスタートしましょう。';
        case 'en':
        default:
          return 'Start your day by logging breakfast to stay perfectly on track.';
      }
    } else if (diff > 500) {
      switch (lang) {
        case 'bn':
          return 'আপনার লক্ষ্য থেকে আর $diff ক্যালোরি বাকি আছে। প্রোটিন সমৃদ্ধ খাবার বজায় রাখুন!';
        case 'ar':
          return 'أنت على بُعد $diff سعرة من هدفك اليومي. حافظ على استهلاك البروتين!';
        case 'es':
          return 'Te faltan $diff kcal para tu meta diaria. ¡Excelente ritmo hoy!';
        case 'fr':
          return 'Il vous reste $diff kcal pour atteindre votre objectif du jour.';
        case 'de':
          return 'Dir fehlen noch $diff kcal zu deinem Tagesziel. Weiter so!';
        case 'hi':
          return 'दैनिक लक्ष्य से $diff कैलोरी बाकी हैं। प्रोटीन पर ध्यान बनाए रखें!';
        case 'ja':
          return '目標まであと $diff kcal。高タンパクな食事がおすすめ！';
        case 'en':
        default:
          return 'You\'re $diff kcal away from your daily goal. Great protein pacing today!';
      }
    } else if (diff >= 0 && diff <= 500) {
      switch (lang) {
        case 'bn':
          return 'লক্ষ্যের খুব কাছাকাছি! আর মাত্র $diff ক্যালোরি বাকি। একটি হালকা পুষ্টিকর নাস্তাই যথেষ্ট।';
        case 'ar':
          return 'أوشكت على الهدف! متبقي فقط $diff سعرة حرارية. وجبة خفيفة ستكفي.';
        case 'es':
          return '¡Casi lo logras! Solo te quedan $diff kcal. Un snack ligero será ideal.';
        case 'fr':
          return 'Presque au but ! Il ne reste que $diff kcal. Une collation légère suffit.';
        case 'de':
          return 'Fast geschafft! Nur noch $diff kcal übrig. Ein leichter Snack reicht.';
        case 'hi':
          return 'लक्ष्य के बहुत करीब! केवल $diff कैलोरी बची हैं। एक हल्का स्नैक पर्याप्त है।';
        case 'ja':
          return '目標達成間近！残り $diff kcal。軽めのスナックが最適です。';
        case 'en':
        default:
          return 'Almost at your target! Only $diff kcal remaining. A healthy light snack will do it.';
      }
    } else {
      switch (lang) {
        case 'bn':
          return 'আজকের ক্যালোরি লক্ষ্যমাত্রা পূর্ণ হয়েছে! পর্যাপ্ত পানি পান ও বিশ্রামের দিকে নজর দিন।';
        case 'ar':
          return 'تم استيفاء هدف السعرات اليومي! ركّز الآن على شرب الماء والراحة.';
        case 'es':
          return '¡Objetivo calórico alcanzado! Enfócate en una buena hidratación.';
        case 'fr':
          return 'Objectif calorique atteint ! Pensez à bien vous hydrater.';
        case 'de':
          return 'Tagesziel erreicht! Achte jetzt auf ausreichende Flüssigkeitszufuhr.';
        case 'hi':
          return 'दैनिक कैलोरी लक्ष्य पूरा हुआ! अब पर्याप्त पानी पीने पर ध्यान दें।';
        case 'ja':
          return '本日のカロリー目標達成！水分補給と十分な休養を心がけましょう。';
        case 'en':
        default:
          return 'Daily calorie goal reached! Prioritize clean hydration and recovery.';
      }
    }
  }

  // Empty state for recent scans
  static String getEmptyScansTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'এখনো কোনো খাবার স্ক্যান করা হয়নি';
      case 'ar':
        return 'لا توجد وجبات ممسوحة مؤخراً';
      case 'es':
        return 'Aún no hay comidas escaneadas';
      case 'fr':
        return 'Aucun repas scanné pour l\'instant';
      case 'de':
        return 'Noch keine Mahlzeiten gescannt';
      case 'hi':
        return 'अभी तक कोई भोजन स्कैन नहीं किया गया';
      case 'ja':
        return '最近のスキャン履歴はありません';
      case 'en':
      default:
        return 'No Recent Food Scans Yet';
    }
  }

  static String getEmptyScansDesc(String lang) {
    switch (lang) {
      case 'bn':
        return 'যেকোনো খাবারের ছবি তুলুন—এআই সেকেন্ডেই পুষ্টি ও ক্যালোরির গভীর বিশ্লেষণ তৈরি করে দেবে।';
      case 'ar':
        return 'التقط صورة لطبقك للحصول على تفكيك كامل للسعرات والمكونات في ثوانٍ.';
      case 'es':
        return 'Fotografía tu comida para generar un análisis nutricional profundo en segundos.';
      case 'fr':
        return 'Photographiez votre plat pour générer une analyse nutritionnelle en quelques secondes.';
      case 'de':
        return 'Fotografiere dein Essen für eine sofortige Nährwert- und Makroaufschlüsselung.';
      case 'hi':
        return 'भोजन की तस्वीर लें और सेकंडों में संपूर्ण कैलोरी व पोषक तत्वों का विवरण प्राप्त करें।';
      case 'ja':
        return '料理の写真を撮影すると、AIが瞬時にカロリーと栄養素の完全な内訳を生成します。';
      case 'en':
      default:
        return 'Capture any home-cooked dish or restaurant meal to generate deep AI nutrition analytics.';
    }
  }

  static String getScanFirstMealButton(String lang) {
    switch (lang) {
      case 'bn':
        return 'প্রথম খাবার স্ক্যান করুন 📸';
      case 'ar':
        return 'امسح أول وجبة الآن 📸';
      case 'es':
        return 'Escanear mi primera comida 📸';
      case 'fr':
        return 'Scanner mon premier repas 📸';
      case 'de':
        return 'Erste Mahlzeit scannen 📸';
      case 'hi':
        return 'पहला भोजन स्कैन करें 📸';
      case 'ja':
        return '最初の食事をスキャン 📸';
      case 'en':
      default:
        return 'Scan Your First Meal 📸';
    }
  }

  // Tools titles
  static String getMealPlannerTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'এআই মিল প্ল্যানার';
      case 'ar':
        return 'مخطط الوجبات بالذكاء';
      case 'es':
        return 'Planificador de comidas';
      case 'fr':
        return 'Planificateur de repas';
      case 'de':
        return 'KI-Ernährungsplan';
      case 'hi':
        return 'एआई मील प्लानर';
      case 'ja':
        return 'AI献立プランナー';
      case 'en':
      default:
        return 'AI Meal Planner';
    }
  }

  static String getMealPlannerSub(String lang) {
    switch (lang) {
      case 'bn':
        return 'কাস্টম ডায়েট প্ল্যান';
      case 'ar':
        return 'خطط غذائية مخصصة';
      case 'es':
        return 'Dietas personalizadas';
      case 'fr':
        return 'Plans sur-mesure';
      case 'de':
        return 'Maßgeschneiderte Pläne';
      case 'hi':
        return 'कस्टम आहार योजना';
      case 'ja':
        return 'パーソナライズ献立';
      case 'en':
      default:
        return 'Personalized diet plans';
    }
  }

  static String getNutritionTrackerTitle(String lang) {
    switch (lang) {
      case 'bn':
        return 'পুষ্টি ট্র্যাকার';
      case 'ar':
        return 'متتبع التغذية';
      case 'es':
        return 'Seguimiento diario';
      case 'fr':
        return 'Journal nutritionnel';
      case 'de':
        return 'Ernährungstracker';
      case 'hi':
        return 'पोषण ट्रैकर';
      case 'ja':
        return '栄養トラッカー';
      case 'en':
      default:
        return 'Nutrition Tracker';
    }
  }

  static String getNutritionTrackerSub(String lang) {
    switch (lang) {
      case 'bn':
        return 'দৈনিক লগ ও হাইহাইড্রেশন';
      case 'ar':
        return 'اليوميات والترطيب';
      case 'es':
        return 'Diario e hidratación';
      case 'fr':
        return 'Journal & hydratation';
      case 'de':
        return 'Tagebuch & Wasser';
      case 'hi':
        return 'दैनिक लॉग और पानी';
      case 'ja':
        return '日次ログと水分記録';
      case 'en':
      default:
        return 'Daily log & hydration';
    }
  }

  static String getWaterLoggedToast(String lang, int amount) {
    switch (lang) {
      case 'bn':
        return '+$amount মিলি পানি যুক্ত করা হয়েছে 💧';
      case 'ar':
        return 'تمت إضافة +$amount مل ماء 💧';
      case 'es':
        return '+$amount ml de agua añadidos 💧';
      case 'fr':
        return '+$amount ml d\'eau ajoutés 💧';
      case 'de':
        return '+$amount ml Wasser hinzugefügt 💧';
      case 'hi':
        return '+$amount मिली पानी दर्ज किया गया 💧';
      case 'ja':
        return '+$amount ml 水分を記録しました 💧';
      case 'en':
      default:
        return '+$amount ml water logged 💧';
    }
  }
}
