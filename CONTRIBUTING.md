# 🤝 Contributing to FoodLens

First off, thank you for considering contributing to **FoodLens**! 🎉

FoodLens is an open-source, global AI food intelligence, computer vision nutrition analysis, and personalized meal planning platform created and maintained by **[CodeByArnob](https://github.com/CodeByArnob)**.

We actively invite developers, UX designers, nutritionists, translators, and open-source enthusiasts worldwide to contribute to FoodLens.

---

## 🧭 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [🔥 Priority Call for Contributions: Authentication & Google Sign-In](#-priority-call-for-contributions-authentication--google-sign-in)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Forking & Local Setup](#forking--local-setup)
- [Development Workflow](#development-workflow)
  - [Branching Conventions](#branching-conventions)
  - [Running the Application](#running-the-application)
  - [Running Static Analysis & Formatting](#running-static-analysis--formatting)
  - [Running the Test Suite](#running-the-test-suite)
- [Reproducing & Investigating Bugs](#reproducing--investigating-bugs)
  - [Authentication & OAuth Testing](#authentication--oauth-testing)
  - [Food Vision & OCR Testing](#food-vision--ocr-testing)
  - [Internationalization & RTL Testing](#internationalization--rtl-testing)
- [Submitting a Pull Request](#submitting-a-pull-request)
- [Issue Templates](#issue-templates)
- [Community & Recognition](#community--recognition)
- [License](#license)

---

## 📜 Code of Conduct

We are dedicated to providing a friendly, safe, and welcoming environment for all contributors, regardless of experience level, gender identity, sexual orientation, disability, personal appearance, race, nationality, or religion. Please be respectful and constructive in all issues, pull requests, and discussions.

---

## 🔥 Priority Call for Contributions: Authentication & Google Sign-In

We currently have a major open technical challenge where community expertise is urgently needed:

> 📌 **Active Help Wanted Issue**:  
> **[Help Wanted: Investigate and Fix Puter.js Authentication and Google Sign-In Integration](https://github.com/CodeByArnob/FoodLens/issues/1)**  
> 📖 **Architecture & Troubleshooting Guide**:  
> **[documentation/AUTHENTICATION_TROUBLESHOOTING.md](documentation/AUTHENTICATION_TROUBLESHOOTING.md)**

### Areas Where Help is Actively Welcomed:
1. **Google OAuth 2.0 Compliance**: Solving Google's `disallowed_useragent` restriction within Android embedded WebViews.
2. **Native Google Sign-In Integration**: Using `google_sign_in` plugin and bridging the resulting auth token to Puter.js.
3. **Android App Links & Chrome Custom Tabs**: Seamless deep-link callback redirect from external browser sign-in back to Flutter.
4. **Session Persistence & Cold Boot**: Reliable token recovery across app restarts without requiring repetitive user sign-in.
5. **Multi-Window WebView Support**: Handling `window.open` popups spawned by Puter.js SDK.

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `^3.44.0` (channel `stable`)
- **Dart SDK**: `^3.12.0`
- **Android SDK**: API 34+ (minSdkVersion 24, compileSdkVersion 34)
- **Java**: JDK 17 (recommended Temurin 17)
- **Git**

### Forking & Local Setup

1. **Fork the Repository**:
   Click the **Fork** button at the top-right of [https://github.com/CodeByArnob/FoodLens](https://github.com/CodeByArnob/FoodLens).

2. **Clone your Fork**:
   ```bash
   git clone https://github.com/<your-username>/FoodLens.git
   cd FoodLens
   ```

3. **Configure Upstream Remote**:
   ```bash
   git remote add upstream https://github.com/CodeByArnob/FoodLens.git
   git fetch upstream
   ```

4. **Install Flutter Dependencies**:
   ```bash
   flutter pub get
   ```

5. **Generate Localization Files**:
   ```bash
   flutter gen-l10n
   ```

---

## 🛠️ Development Workflow

### Branching Conventions

Always create a dedicated feature or bugfix branch off `upstream/main`:

```bash
git checkout -b fix/puter-auth-popup
# or
git checkout -b feat/glycemic-index-filter
# or
git checkout -b l10n/arabic-rtl-refinement
```

Use descriptive branch prefixes:
- `fix/` for bug fixes and patches
- `feat/` for new features or user enhancements
- `auth/` for authentication and OAuth improvements
- `l10n/` for translations and locale adjustments
- `docs/` for documentation updates
- `test/` for adding or improving test coverage

### Running the Application

Launch the app on a connected physical Android device or emulator:
```bash
flutter run
```

For verbose logging of the Puter.js WebView bridge:
```bash
flutter run -v
```

### Running Static Analysis & Formatting

Ensure your code matches project formatting and passes all static analysis checks before committing:

1. **Format Dart code**:
   ```bash
   dart format lib test
   ```
2. **Verify format compliance (matches CI check)**:
   ```bash
   dart format --output=none --set-exit-if-changed lib test
   ```
3. **Run Flutter Analyzer**:
   ```bash
   flutter analyze
   ```
   > ⚠️ Must exit with **0 issues found**!

### Running the Test Suite

Run all unit and widget tests:
```bash
flutter test
```

For detailed per-test reporting:
```bash
flutter test --reporter expanded
```

---

## 🔍 Reproducing & Investigating Bugs

### Authentication & OAuth Testing
1. Review [`documentation/AUTHENTICATION_TROUBLESHOOTING.md`](documentation/AUTHENTICATION_TROUBLESHOOTING.md).
2. Start the app, navigate to Onboarding or Profile > Settings > Puter Account.
3. Test both **Puter Account Login** and **Google Sign-In**.
4. Capture logs via `adb logcat`:
   ```bash
   adb logcat -s PuterBridge chromium
   ```

### Food Vision & OCR Testing
FoodLens supports testing with both live cameras and sample assets stored in `assets/images/`:
- `salmon_bowl.jpg`
- `margherita_pizza.jpg`
- `avocado_toast.jpg`
- `lentil_dal.jpg`

Test scanner parsing logic by injecting sample images via `ScannerService`.

### Internationalization & RTL Testing
FoodLens supports 8 languages with dynamic switching in **Settings > App Language**:
- When modifying Bengali (`lib/l10n/app_bn.arb`), verify rendering with `GoogleFonts.hindSiliguri()`.
- When modifying Arabic (`lib/l10n/app_ar.arb`), verify Right-to-Left (RTL) mirroring, chevrons, gauge alignments, and `GoogleFonts.cairo()`.
- After modifying any `.arb` file, re-run `flutter gen-l10n` and execute `flutter test`.

---

## 📤 Submitting a Pull Request

1. **Sync with Upstream**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```
2. **Ensure CI Checks Pass Locally**:
   ```bash
   dart format --output=none --set-exit-if-changed lib test
   flutter analyze
   flutter test
   ```
3. **Push to Your Fork**:
   ```bash
   git push origin <your-branch-name>
   ```
4. **Open a Pull Request**:
   - Go to your fork on GitHub and click **Compare & pull request**.
   - Target branch: `main` of `CodeByArnob/FoodLens`.
   - Include a clear title (e.g., `fix(auth): implement Chrome Custom Tabs redirect for Google OAuth`).
   - Fill in the PR description:
     - What problem does this PR solve?
     - How was it tested? (physical device, emulator, unit tests)
     - Attach before/after screenshots or logs if modifying UI.

---

## 📋 Issue Templates

When filing an issue on GitHub, please select the most relevant template:
- **🐛 Bug Report**: For defects and runtime crashes.
- **🔐 Authentication Problem**: For Puter.js sign-in, token expiration, or bridge timeouts.
- **🔑 Google Sign-In Failure**: Specifically for Google OAuth 403 `disallowed_useragent` errors.
- **📸 AI Food Scanner & OCR Problem**: For dish recognition or nutrition label extraction errors.
- **✨ Feature Request**: For proposals of new capabilities.
- **🌐 Localization & Translation Improvement**: For improving or adding language translations.

---

## 🏆 Community & Recognition

All contributors who have pull requests merged will be:
- Credited in the official `README.md` Contributors section.
- Featured in the in-app **About FoodLens** screen.
- Listed in GitHub Release notes.

---

## 📜 License

By contributing to FoodLens, you agree that your contributions will be licensed under the project's [MIT License](LICENSE).

<div align="center">
  <sub>Created with passion by <b><a href="https://github.com/CodeByArnob">CodeByArnob</a></b> ❤️</sub>
</div>
