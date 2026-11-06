# Changelog

All notable changes to the **FoodLens** project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-11-06

### Initial Public Open-Source Release

#### 🌟 Core Features
- **AI-Powered Food & Label Scanner**: Instant recognition of prepared meals, raw ingredients, and packaged nutrition labels with bounding boxes and real-time processing indicators.
- **Deep Nutritional Breakdown**: Calculates calories, macronutrient distribution (Protein, Carbs, Fats), micronutrients (Sodium, Fiber, Sugars, Cholesterol, Potassium), and glycemic impact.
- **Health Score & Quality Rating**: Proprietary algorithmic food quality index rating foods from 1 to 100 with actionable feedback.
- **Allergen & Dietary Safety Warnings**: Automated detection and alerts for gluten, dairy, nuts, soy, shellfish, halal, kosher, and vegan dietary criteria.
- **Smart Meal Planner**: Generate and customize daily breakfast, lunch, dinner, and snack regimens tailored to individual calorie targets and macronutrient splits.
- **Food Comparison Engine**: Side-by-side nutritional comparison of dishes with intelligent dietary verdict highlights.
- **Interactive Calorie Gauge & Macro Rings**: Visual daily consumption dials and macronutrient breakdown charts built with `fl_chart`.
- **Restaurant Menu Explorer**: Scan and parse complex dining menus into searchable, macro-tagged dish items with localized prices.

#### 🔐 Puter.js User-Pays Architecture
- **Zero-Server Backend Cost**: Direct client-side Puter.js bridge handles cloud AI inference without requiring a dedicated backend server or developer API keys.
- **User-Pays Quota Management**: Users sign in with their personal Puter account, granting transparent quota monitoring and direct tier management.
- **Privacy-First Processing**: Personal nutrition logs and scan history reside locally on device via encrypted shared storage; images sent to AI endpoints are processed ephemerally.

#### 🌍 Internationalization & Localization
- **8 Supported Languages**:
  - English (`en`)
  - Bengali (`bn` - বাংলা) with full authentic script support
  - Arabic (`ar` - العربية) with full Right-to-Left (RTL) directional layout
  - German (`de` - Deutsch)
  - Spanish (`es` - Español)
  - French (`fr` - Français)
  - Hindi (`hi` - हिन्दी)
  - Japanese (`ja` - 日本語)
- **Multi-Currency Support**: Dynamic conversion between USD (`$`), BDT (`৳`), EUR (`€`), GBP (`£`), INR (`₹`), JPY (`¥`), and SAR (`ر.س`).
- **Flexible Unit Systems**: Seamless metric (grams, ml, kg) and imperial (oz, fl oz, lbs) unit conversion.

#### 🎨 Design & Experience
- **Material 3 Fluid UI**: Modern glassmorphic cards, adaptive light and dark themes, and dynamic color accents.
- **Haptic Feedback**: Tactile feedback on critical user interactions and scanner triggers.
- **Offline Fallback Database**: Offline local JSON database containing comprehensive nutritional profiles for standard everyday foods.

#### 🛠️ Tooling & Infrastructure
- Complete Flutter 3.44+ test suite with unit, widget, and state resilience tests.
- Automated GitHub Actions CI workflow for code formatting, analysis, testing, and universal APK compilation.
