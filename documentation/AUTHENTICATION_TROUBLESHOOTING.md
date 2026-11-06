# 🔐 FoodLens Authentication Architecture & Troubleshooting Guide

> **Status: OPEN — Contributions and Technical Investigations Actively Welcomed**  
> **Lead Maintainer**: [CodeByArnob](https://github.com/CodeByArnob)  
> **Related GitHub Issue**: [Help Wanted: Investigate and Fix Puter.js Authentication and Google Sign-In Integration](https://github.com/CodeByArnob/FoodLens/issues)

---

## 📋 Executive Summary

FoodLens implements a decentralized **User-Pays computing model** using [Puter.js](https://puter.com). Instead of requiring developers to maintain private API keys or pay central server hosting fees for computer vision inference, users authenticate directly with their own personal Puter accounts. Puter grants each user a monthly free AI allowance ($10.00/month) that powers Claude 3.5 Sonnet / Vision queries for food and nutrition analysis.

While the in-app bridge and offline fallback mechanisms function properly, **Puter.js authentication and Google OAuth 2.0 federation encounter critical limitations within native Android WebViews**. This document provides an exhaustive architectural overview of the authentication pipeline, analyzes the root causes of current issues, and invites community developers to contribute robust solutions.

---

## 🏗️ Flutter-to-Puter.js Integration Architecture

The integration between Flutter and Puter.js is achieved via a local headless/interactive WebView hosting an HTML bridge containing the official Puter.js SDK (`https://js.puter.com/v2/`).

```
┌─────────────────────────────────────────────────────────────┐
│                 Flutter Application (Dart)                  │
│                                                             │
│  ┌───────────────────────┐       ┌───────────────────────┐  │
│  │      AuthState        │       │  PuterBridgeService   │  │
│  │   (Riverpod State)    │◄──────┤ (WebView Controller)  │  │
│  └───────────────────────┘       └───────────┬───────────┘  │
└──────────────────────────────────────────────┼──────────────┘
                                               │
                        Bi-directional Bridge  │ JavascriptChannel('PuterBridge')
                                               │ runJavaScript()
┌──────────────────────────────────────────────▼──────────────┐
│          Android System WebView (HTML / JavaScript)         │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │               assets/html/puter_bridge.html           │  │
│  │  - puter.auth.isSignedIn()                            │  │
│  │  - puter.auth.signIn()                                │  │
│  │  - puter.auth.getUser()                               │  │
│  │  - puter.os.getMonthlyUsage()                         │  │
│  │  - puter.ai.chat(imagePayload, prompt)                │  │
│  └───────────────────────────┬───────────────────────────┘  │
└──────────────────────────────┼──────────────────────────────┘
                               │ HTTPS / WSS
┌──────────────────────────────▼──────────────────────────────┐
│                 Puter Cloud (https://puter.com)             │
│  - User Auth Service (Puter native & OAuth Federation)       │
│  - AI Vision Inference (Claude 3.5 Sonnet / GPT-4o)         │
│  - Monthly Usage & Credit Accounting                         │
└─────────────────────────────────────────────────────────────┘
```

### Relevant Code Locations
- **JavaScript Bridge**: [`assets/html/puter_bridge.html`](../assets/html/puter_bridge.html)
- **Dart Bridge Service**: [`lib/features/auth/services/puter_bridge_service.dart`](../lib/features/auth/services/puter_bridge_service.dart)
- **Auth Provider State**: [`lib/features/auth/providers/auth_provider.dart`](../lib/features/auth/providers/auth_provider.dart)
- **In-App WebView Screen**: [`lib/features/auth/screens/puter_auth_webview_screen.dart`](../lib/features/auth/screens/puter_auth_webview_screen.dart)
- **Local Persistence**: [`lib/shared/services/local_storage_service.dart`](../lib/shared/services/local_storage_service.dart)

---

## ⚠️ Known Problems & Root Cause Analysis

### 1. Google OAuth User-Agent Block (`Error 403: disallowed_useragent`)
- **Status**: **OPEN / UNRESOLVED**
- **Symptom**: When a user attempts to sign into Puter using the "Sign in with Google" button inside the embedded `PuterAuthWebViewScreen`, Google rejects the request with:
  ```
  403 Error: disallowed_useragent
  Google can't sign you in safely inside this app.
  To keep your account secure, Google doesn't allow you to sign in from within certain browsers or embedded WebViews.
  ```
- **Technical Cause**: In compliance with [Google's OAuth 2.0 Security Policy](https://developers.googleblog.com/2016/08/modernizing-oauth-interactions-in-native-apps.html), Google blocks OAuth authorization requests from embedded WebViews (including Android `WebView` and iOS `WKWebView`) to prevent Man-in-the-Middle (MITM) attacks and credential interception.
- **Current Limitation**: Custom user-agent string spoofing is fragile, violates Google Play Store developer guidelines, and is actively patched by Google Identity endpoints.

---

### 2. External Browser Authentication & Missing Session Synchronization
- **Status**: **OPEN / UNRESOLVED**
- **Symptom**: If the authentication flow redirects to an external browser (e.g., Chrome Custom Tabs or device default browser via `url_launcher`), the user can successfully sign into Puter.com, but the resulting authentication token and cookies reside in Chrome's cookie store rather than the app's internal WebView storage.
- **Technical Cause**:
  1. The Flutter in-app WebView operates in an isolated sandbox (`data/data/com.foodlens.foodlens/app_webview`) that does not share cookies or `localStorage` with external browsers.
  2. Puter.js currently relies on domain cookies (`puter.com`) or client-side JavaScript state initialized through its window context.
  3. Without a custom deep-link redirect mechanism (e.g., `foodlens://auth?token=...` or Android App Links), the external browser cannot pass the auth token back to Flutter.

---

### 3. Pop-up Window Handling in Android WebView
- **Status**: **OPEN / UNRESOLVED**
- **Symptom**: The Puter.js SDK (`puter.auth.signIn()`) is designed primarily for desktop web browsers where it invokes `window.open()` to present a modal sign-in popup.
- **Technical Cause**:
  - In Android's `webview_flutter`, popup windows (`window.open`) require explicit `onCreateWindow` delegate handlers and multi-window support (`setSupportMultipleWindows(true)`).
  - Without full window orchestration, tapping "Sign in with Puter" within the embedded bridge can hang or become unresponsive.

---

### 4. Session Persistence and Cold Boot Restoration
- **Status**: **PARTIALLY MITIGATED VIA LOCAL CACHE / OPEN FOR REFINED RE-AUTH**
- **Symptom**: When the user force-quits the app or the device reboots, the WebView context is reinitialized.
- **Current Workaround**:
  - FoodLens caches the `PuterUser` JSON representation and token in `SharedPreferences`.
  - On app launch, `AuthProvider` immediately restores cached user credentials so the UI displays the user name and cached balance.
  - However, when subsequent AI requests are sent to the newly initialized `puter_bridge.html`, the bridge must re-verify authentication with Puter's backend. If the session expired or cookies were cleared, the AI query fails with `PuterAuthException`.

---

## 🎯 Proposed Solutions & Architecture Roadmap

We are seeking pull requests and architectural proposals from the developer community for the following directions:

### Solution A: Native Android Google Sign-In with Custom Backend / Bridge Exchange
1. Integrate the official [`google_sign_in`](https://pub.dev/packages/google_sign_in) Flutter plugin for 100% compliant, secure Google OAuth on Android.
2. Exchange the obtained Google `id_token` or `serverAuthCode` directly with Puter's authentication API to establish a valid Puter session token.
3. Inject the session token directly into `puter_bridge.html` via `puter.auth.setToken(token)`.

### Solution B: Chrome Custom Tabs + Android App Links (Deep Linking)
1. Initiate authentication via Android Custom Tabs (`flutter_custom_tabs`).
2. Configure Android App Links (`https://foodlens.app/auth/callback` or custom URI scheme `foodlens://auth-callback`).
3. Have Puter redirect back to the custom URI scheme containing authorization parameters.
4. Catch the intent in Flutter, extract the auth token, and pass it into `PuterBridgeService`.

### Solution C: Multi-Window Embedded WebView Support
1. Extend `webview_flutter_android` settings to support multiple windows:
   ```kotlin
   settings.setSupportMultipleWindows(true)
   settings.javaScriptCanOpenWindowsAutomatically = true
   ```
2. Present `window.open` requests in a companion modal overlay dialog, allowing standard Puter login dialogues to complete without external browser handoffs.

---

## 🛠️ How to Reproduce Current Issues Locally

1. Connect an Android physical device or start an Android 13+ emulator:
   ```bash
   flutter devices
   ```
2. Build and run FoodLens in debug mode with verbose logging:
   ```bash
   flutter run -v
   ```
3. Navigate to **Profile** > **Settings & Preferences** > **Puter Account**.
4. Tap **Sign In to Puter Cloud**.
5. When the Puter web interface opens, tap **Continue with Google**.
6. Inspect the resulting Google `disallowed_useragent` warning screen or inspect the ADB logcat output:
   ```bash
   adb logcat | grep -E "PuterBridge|chromium"
   ```

---

## 🤝 Calling All Contributors!

If you have experience in:
- **Flutter & Native Android WebView integration**
- **Google Identity Services & OAuth 2.0 PKCE flows**
- **Android App Links & Custom Tabs**
- **Puter.js SDK internals**

Please join our effort! Feel free to:
- Review the [Open Help Wanted Issue](https://github.com/CodeByArnob/FoodLens/issues)
- Open a discussion or propose an RFC
- Submit a pull request following our [CONTRIBUTING.md](../CONTRIBUTING.md) guidelines

*Let's build a truly open, privacy-respecting, and resilient food intelligence app together!*
