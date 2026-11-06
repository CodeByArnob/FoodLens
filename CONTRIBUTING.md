# Contributing to FoodLens

Thank you for considering contributing to FoodLens.

FoodLens is an open-source, global AI food intelligence, computer vision nutrition analysis, and personalized meal planning platform created and maintained by [CodeByArnob](https://github.com/CodeByArnob).

We actively invite developers, UX designers, nutritionists, translators, and open-source enthusiasts worldwide to contribute to FoodLens.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Priority Call for Contributions: External Browser Puter Authentication](#priority-call-for-contributions-external-browser-puter-authentication)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Forking and Local Setup](#forking-and-local-setup)
- [Development Workflow](#development-workflow)
  - [Branching Conventions](#branching-conventions)
  - [Running the Application](#running-the-application)
  - [Running Static Analysis and Formatting](#running-static-analysis-and-formatting)
  - [Running the Test Suite](#running-the-test-suite)
- [Reproducing and Investigating Issues](#reproducing-and-investigating-issues)
  - [Authentication Testing](#authentication-testing)
  - [Food Vision and OCR Testing](#food-vision-and-ocr-testing)
  - [Internationalization and RTL Testing](#internationalization-and-rtl-testing)
- [Submitting a Pull Request](#submitting-a-pull-request)
- [Issue Templates](#issue-templates)
- [Community and Recognition](#community-and-recognition)
- [License](#license)

---

## Code of Conduct

FoodLens follows the Contributor Covenant. We are dedicated to providing a friendly, safe, and welcoming environment for all contributors, regardless of experience level, gender identity, sexual orientation, disability, personal appearance, race, nationality, or religion. Please be respectful and constructive in all issues, pull requests, and community discussions. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for full details.

---

## Priority Call for Contributions: External Browser Puter Authentication

We currently have a high-priority open technical challenge where community investigation and code contributions are actively requested:

> **[Help Wanted: Open Puter Login and Sign Up in the External Default Browser](https://github.com/CodeByArnob/FoodLens/issues/1)**

### The Challenge
FoodLens operates on a decentralized User-Pays architecture powered by Puter.js. Instead of requiring centralized backend servers or shared developer API keys, each user connects their personal Puter account and consumes their own complimentary monthly free allowance ($10.00 monthly quota).

Currently, the authentication flow opens inside an internal embedded WebView within the mobile application. We want both **Login** and **Sign Up** to open in the user actual Android default external browser (such as Chrome, Firefox, or Samsung Internet). After completing authentication, the user should return smoothly to FoodLens with their account session recognized and persisted.

### Areas for Investigation
1. **Puter.js SDK Capabilities**: Research whether official Puter.js documentation or newer SDK releases support redirect URIs, OAuth PKCE flows, or mobile browser delegation.
2. **Android Intent and Deep Linking**: Establishing an Android App Link or Custom Scheme callback (such as `foodlens://auth/callback`) to return control from the browser back to Flutter.
3. **Session Handshake**: Safely transmitting the authenticated session or token into the app without insecure query parameters or plaintext exposure.
4. **Offline and Cold Boot Persistence**: Storing the verified session token securely in encrypted local storage (`flutter_secure_storage`).

Please read our detailed [Authentication Troubleshooting Guide](documentation/AUTHENTICATION_TROUBLESHOOTING.md) and participate in [Issue #1](https://github.com/CodeByArnob/FoodLens/issues/1).

---

## Getting Started

### Prerequisites
Before contributing, ensure you have the following installed on your machine:
- **Flutter SDK**: version 3.29.0 or later (channel stable)
- **Dart SDK**: version 3.7.0 or later
- **Android SDK**: API level 34 or later (Android Studio recommended)
- **Java Development Kit**: JDK 17 (recommended for Gradle 8 compatibility)
- **Git**: version 2.30 or later

Verify your environment with:
```shell
flutter doctor -v
```

### Forking and Local Setup
1. Fork the repository on GitHub by clicking the **Fork** button at [https://github.com/CodeByArnob/FoodLens](https://github.com/CodeByArnob/FoodLens).
2. Clone your personal fork locally:
   ```shell
   git clone https://github.com/<your-username>/FoodLens.git
   cd FoodLens
   ```
3. Set the upstream remote to stay synchronized with official updates:
   ```shell
   git remote add upstream https://github.com/CodeByArnob/FoodLens.git
   ```
4. Install all Flutter dependencies:
   ```shell
   flutter pub get
   ```

---

## Development Workflow

### Branching Conventions
Always create a focused branch from `upstream/main`:
```shell
git checkout -b feat/your-feature-name
# or
git checkout -b fix/issue-description
```

Use standardized branch prefixes:
- `feat/`: New user-facing capabilities or enhancements
- `fix/`: Bug fixes or defects
- `docs/`: Documentation updates, guides, or comments
- `refactor/`: Code improvements that do not change external behavior
- `test/`: New automated tests or test suite improvements

### Running the Application
Connect a physical Android device with USB debugging enabled, or start an Android emulator:
```shell
flutter devices
flutter run
```

### Running Static Analysis and Formatting
FoodLens enforces strict code formatting and zero linter warnings. Before opening a pull request, run:

1. **Format all Dart files**:
   ```shell
   dart format lib test
   ```
2. **Check for formatting compliance**:
   ```shell
   dart format --output=none --set-exit-if-changed lib test
   ```
3. **Run Flutter static analyzer**:
   ```shell
   flutter analyze
   ```
   *Your PR will only be merged if `flutter analyze` reports 0 issues.*

### Running the Test Suite
FoodLens maintains an automated test suite covering state management, localization, food recognition models, and core widgets:
```shell
flutter test
```
To run tests with code coverage:
```shell
flutter test --coverage
```

---

## Reproducing and Investigating Issues

### Authentication Testing
- Open the application and navigate to Settings or Onboarding.
- Select Sign In with Puter or Sign Up.
- Verify browser interaction, network status, and session token receipt.
- Do not commit personal auth tokens or credentials.

### Food Vision and OCR Testing
- The AI scanner module is located in `lib/features/scanner/`.
- Test dish recognition, ingredient analysis, and nutrition estimation across various food categories (fresh produce, packaged food labels, restaurant menus).
- Verify fallback behavior when network connectivity is slow or unavailable.

### Internationalization and RTL Testing
FoodLens supports 7 international languages and full bidirectional layout:
- English (en)
- Bengali (bn)
- Arabic (ar, Right-to-Left)
- Spanish (es)
- French (fr)
- German (de)
- Japanese (ja)

When adding or modifying localized strings:
1. Update all language files in `lib/l10n/` or `lib/core/localization/`.
2. Test both Left-to-Right (LTR) and Right-to-Left (RTL) screen orientations.
3. Verify that numbers, currency symbols, and text directions render accurately.

---

## Submitting a Pull Request

Follow these steps to submit your contribution:

1. **Sync with upstream**:
   ```shell
   git checkout main
   git fetch upstream
   git merge upstream/main
   git checkout your-branch-name
   git rebase main
   ```
2. **Verify all checks pass**:
   ```shell
   dart format --output=none --set-exit-if-changed lib test
   flutter analyze
   flutter test
   ```
3. **Commit your changes**:
   Write clear, concise commit messages following the Conventional Commits specification:
   ```shell
   git commit -m "fix(auth): investigate external browser delegation for Puter login"
   ```
4. **Push to your fork**:
   ```shell
   git push origin your-branch-name
   ```
5. **Open a Pull Request**:
   Go to [https://github.com/CodeByArnob/FoodLens](https://github.com/CodeByArnob/FoodLens) and click **Compare & pull request**.
   - Fill out the provided PR template completely.
   - Reference any relevant issues (for example, `Fixes #1`).
   - Include screenshots or screen recordings for visual changes.

---

## Issue Templates

When reporting issues or proposing ideas, use our structured issue templates:
- **Authentication Problem**: For Puter.js sign-in, session persistence, or external browser integration.
- **Bug Report**: For reproducible errors, crashes, or broken behavior.
- **Camera and Image Scanning Bug**: For hardware camera access, permissions, or image capture defects.
- **AI Scanner Problem**: For dish recognition accuracy, OCR parsing, or nutrition miscalculations.
- **Feature Request**: For proposing new features or dietary tools.
- **Localization Improvement**: For translation updates or RTL formatting fixes.

---

## Community and Recognition

All contributors will be credited in our release notes, project documentation, and GitHub contributor list. FoodLens is built by the global open-source community for health and nutrition enthusiasts everywhere.

If you have questions, feel free to open an issue or join our community discussions.

---

## License

By contributing to FoodLens, you agree that your contributions will be licensed under the project's [MIT License](LICENSE).
