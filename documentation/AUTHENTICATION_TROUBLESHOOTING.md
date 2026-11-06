# Puter Authentication Architecture and Troubleshooting Guide

Status: OPEN (Contributions and Technical Investigations Actively Welcomed)  
Lead Maintainer: CodeByArnob  
Related GitHub Issue: [Help Wanted: Open Puter Login and Sign Up in the External Default Browser](https://github.com/CodeByArnob/FoodLens/issues/1)

---

## Overview

FoodLens utilizes a decentralized User-Pays computing model powered by Puter.js. Rather than relying on central developer API keys or bearing recurring hosting costs for cloud vision services, users connect their personal Puter accounts. Puter provides each user with a complimentary monthly AI allowance ($10.00 monthly quota) that processes vision requests for food and nutrition analysis.

Currently, the authentication flow opens within an internal embedded WebView inside the Flutter application. To enhance usability, security, and integration with system password managers, the project goal is to allow both Login and Sign Up to execute directly within the user default external Android browser (such as Chrome, Firefox, or Samsung Internet) and then return smoothly to FoodLens with their session recognized.

This document outlines the current technical architecture, known limitations, official Puter.js documentation findings, and guidance for open-source contributors.

---

## Current Architecture

The Flutter application interfaces with Puter.js using a local bridge service hosted inside an Android WebView component:

1. Flutter UI (Dart):
   - The user triggers sign-in through Onboarding or Profile Settings.
   - `AuthProvider` manages the reactive state using Riverpod.
   - `PuterBridgeService` initializes the WebView and handles bidirectional communication.

2. Local JavaScript Bridge:
   - File path: `assets/html/puter_bridge.html`
   - Script reference: Official Puter.js SDK (`https://js.puter.com/v2/`)
   - Channel: `JavascriptChannel('PuterBridge')` relays callbacks and events between Dart and JavaScript.

3. Puter Cloud:
   - Endpoint: `https://puter.com`
   - Handles user account creation, credentials, and monthly usage metrics (`puter.os.getMonthlyUsage()`).

### Relevant Code Locations
- JavaScript Bridge: `assets/html/puter_bridge.html`
- Dart Bridge Service: `lib/features/auth/services/puter_bridge_service.dart`
- In-App Auth Screen: `lib/features/auth/screens/puter_auth_webview_screen.dart`
- Auth State Management: `lib/features/auth/providers/auth_provider.dart`
- Local Storage Persistence: `lib/shared/services/local_storage_service.dart`

---

## Known Limitations and Investigation Findings

### 1. In-App WebView Usability Limitations
The current implementation renders an in-app WebView (`PuterAuthWebViewScreen`). While operational, embedded WebViews introduce several usability challenges:
- Users cannot easily access credentials saved in their primary password managers.
- Browser-level autofill and passkey features are often constrained inside embedded components.
- Pop-up windows spawned by JavaScript SDK calls require complex Android window management.

### 2. Session Isolation Between External Browsers and Mobile WebViews
When authentication is initiated in an external browser:
- The resulting authentication cookies and session state are retained in the external browser storage profile.
- Native Android applications operate in an isolated sandbox (`/data/data/com.foodlens.foodlens/app_webview`) that cannot read external browser cookies or local storage.
- Consequently, simply opening `https://puter.com/auth` in an external browser does not automatically synchronize the session back into the application embedded bridge.

### 3. Puter.js SDK Mechanics
Investigation of official Puter.js documentation indicates:
- `puter.auth.signIn()` is architected for web applications where modal dialogs or popups (`window.open`) are standard.
- The public Puter SDK documentation emphasizes browser-based workflows.
- Research is required to determine whether Puter provides an official mobile redirection flow, PKCE callback, or dedicated mobile authorization endpoint.

---

## Architectural Directions for Investigation

We invite developers to research and propose verified approaches:

### Direction A: Official Puter Redirect or Deep-Link Callback
1. Investigate whether Puter supports authorization redirects with custom schemes (such as `foodlens://auth/callback`) or verified Android App Links.
2. If supported, the external browser completes sign-in and redirects to the registered URI scheme, passing authorization parameters back into Flutter.
3. Flutter captures the intent, communicates with the Puter token endpoint to exchange for a session token, and passes the token into `PuterBridgeService`.

### Direction B: Android Chrome Custom Tabs with Session Bridging
1. Launch authentication within Chrome Custom Tabs (`androidx.browser.customtabs`).
2. Utilize shared web credentials or an authorized token handoff to capture the resulting session securely.

### Direction C: Consultation with Puter Maintainers
1. If the current Puter.js SDK only supports popup-based web sign-in, consult the Puter core engineering team to identify recommended patterns for native mobile applications.
2. Avoid inventing undocumented workarounds that could compromise user credential security.

---

## Security and Community Guidelines

All proposed solutions must follow these non-negotiable rules:
1. User-Pays Integrity: Users must log into their own Puter accounts and use their own free monthly quota.
2. No Insecure Token Passing: Tokens must never be exposed via plain, unencrypted, or logged URL query parameters.
3. No Hardcoded Secrets: No private keys or developer credentials may be committed to the repository.
4. Clean Code Quality: All code must pass `dart format`, `flutter analyze` with 0 issues, and all existing unit tests in `flutter test`.

---

## Reproduction and Testing Steps

1. Start a physical Android device or emulator running API 24+.
2. Launch FoodLens:
   ```shell
   flutter run
   ```
3. Open Profile Settings and tap Puter Account.
4. Observe the current in-app WebView interface.
5. Review the logcat stream:
   ```shell
   adb logcat -s PuterBridge chromium
   ```

To contribute a solution, please review [CONTRIBUTING.md](../CONTRIBUTING.md) and participate in [Issue #1](https://github.com/CodeByArnob/FoodLens/issues/1).
