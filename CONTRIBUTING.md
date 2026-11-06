# Contributing to FoodLens

Thank you for your interest in contributing to **FoodLens**! We welcome contributions from developers, designers, nutritionists, translators, and testers around the world.

FoodLens is a global, privacy-first AI food intelligence and nutrition platform powered by Flutter, Riverpod, and Puter.js User-Pays architecture.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Improving Translations](#improving-translations)
  - [Submitting Code Changes](#submitting-code-changes)
- [Development Setup](#development-setup)
- [Architecture Overview](#architecture-overview)
- [Coding Guidelines](#coding-guidelines)
- [Testing Standards](#testing-standards)
- [Pull Request Process](#pull-request-process)
- [License](#license)

---

## Code of Conduct

We are committed to providing a welcoming, inclusive, and harassment-free environment for everyone. Please be respectful, considerate, and constructive in all interactions within issues, pull requests, and discussions.

---

## How Can I Contribute?

### Reporting Bugs

Before creating an issue, please search existing issues to avoid duplicates. When filing a bug report, include:
1. **Device & OS version** (e.g., Android 13, Realme 8 / Pixel 7).
2. **Flutter version** (`flutter --version`).
3. **Clear steps to reproduce** the issue.
4. **Expected vs. actual behavior**.
5. **Screenshots or logs** (e.g., `flutter run -v` or `adb logcat`).

### Suggesting Features

Feature requests should clearly explain:
- The problem the feature solves.
- Proposed user interface / experience.
- Any relevant data formats, dietary standards, or external APIs.

### Improving Translations

FoodLens aims to be accessible to everyone globally. Localizations reside in `lib/l10n/`:
- `app_en.arb` (English - source template)
- `app_bn.arb` (Bengali - বাংলা)
- `app_ar.arb` (Arabic - العربية, RTL layout)
- `app_de.arb` (German - Deutsch)
- `app_es.arb` (Spanish - Español)
- `app_fr.arb` (French - Français)
- `app_hi.arb` (Hindi - हिन्दी)
- `app_ja.arb` (Japanese - 日本語)

To add or refine a translation, edit the corresponding `.arb` file and run `flutter gen-l10n`.

---

## Development Setup

### Prerequisites
- **Flutter SDK**: `>= 3.44.0` (Dart `>= 3.12.0`)
- **Android SDK**: API level 34+ (Android 14) recommended, minimum SDK 24 (Android 7.0)
- **Java**: JDK 17
- **Git**

### Installation

1. Fork and clone the repository:
   ```bash
   git clone https://github.com/CodeByArnob/FoodLens.git
   cd FoodLens
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run static analysis:
   ```bash
   flutter analyze
   ```

4. Execute test suite:
   ```bash
   flutter test
   ```

5. Launch the application:
   ```bash
   flutter run
   ```

---

## Architecture Overview

FoodLens follows a feature-driven, clean architecture powered by **Riverpod**:

```
lib/
├── core/               # Cross-cutting concerns (theme, routing, utils, errors, constants)
│   ├── constants/      # App colors, dietary constants, food classifications
│   ├── errors/         # Typed exception hierarchy
│   ├── router/         # GoRouter declarative configuration
│   ├── services/       # Currency exchange rates, formatters
│   ├── theme/          # Material 3 dynamic themes (Light / Dark)
│   └── utils/          # Haptics, unit converters, localization helpers
├── features/           # Modular domain features
│   ├── auth/           # Puter.js bridge, authentication & quota monitoring
│   ├── comparison/     # Side-by-side nutritional food comparison engine
│   ├── dashboard/      # Main shell, calorie gauge, health insights
│   ├── history_favorites/ # Scan history and favorite meals
│   ├── meal_planner/   # Calorie-target meal planning and macronutrient allocation
│   ├── menu_explorer/  # Restaurant menu items and dining guides
│   ├── nutrition_tracking/ # Daily food logs and timeline tracking
│   ├── scanner/        # Live camera viewfinder, OCR label & dish analysis
│   └── settings/       # Language selection, currency formatting, units, profile
├── l10n/               # Internationalization (.arb files)
└── shared/             # Reusable UI widgets and local storage services
```

---

## Coding Guidelines

- **Effective Dart**: Follow standard [Effective Dart](https://dart.dev/guides/language/effective-dart) practices.
- **Linter**: Ensure all code satisfies `flutter_lints` defined in `analysis_options.yaml`.
- **State Management**: Use `flutter_riverpod` providers. Avoid raw `setState` for non-ephemeral state.
- **RTL Support**: All UI layouts must support Right-to-Left (RTL) reading directions (e.g., Arabic). Use `DirectionalChevron` and directional padding where applicable.
- **Security & Privacy**: Never hardcode private keys, personal tokens, or API credentials. All AI calls flow through the client-side Puter.js User-Pays bridge.

---

## Testing Standards

All pull requests introducing new logic or fixing bugs must include corresponding tests:
- Place unit tests under `test/unit_test.dart` or feature-specific test files.
- Place widget and interaction tests under `test/widget_test.dart`.
- Run all tests before submitting:
  ```bash
  flutter test
  ```

---

## Pull Request Process

1. Create a feature branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
2. Commit your changes with clear, descriptive commit messages adhering to [Conventional Commits](https://www.conventionalcommits.org/):
   - `feat: add glycemic index filter to food search`
   - `fix: correct RTL padding in meal planner card`
   - `docs: update Puter.js user-pays flow diagram`
3. Ensure `flutter analyze` and `flutter test` pass locally.
4. Push your branch and open a Pull Request against `main`.
5. Provide a summary of changes, rationale, and screenshots for UI modifications.

---

## License

By contributing to FoodLens, you agree that your contributions will be licensed under the project's [MIT License](LICENSE).
