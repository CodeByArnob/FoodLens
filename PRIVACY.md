# Privacy Policy for FoodLens

**Effective Date**: November 6, 2026  
**Last Updated**: November 6, 2026  
**Lead Maintainer**: [CodeByArnob](https://github.com/CodeByArnob)  
**Official Repository**: [https://github.com/CodeByArnob/FoodLens](https://github.com/CodeByArnob/FoodLens)

---

## 1. Introduction and Core Philosophy

Welcome to FoodLens. FoodLens is an open-source, global AI food intelligence, computer vision nutrition analysis, and personalized meal planning application created and maintained by **CodeByArnob**.

Our founding engineering philosophy is simple: **Privacy by Design**. We believe that your dietary habits, nutritional choices, personal health metrics, and meal history belong entirely to you. Unlike commercial nutrition applications that harvest user behavioral data, inject advertising trackers, or resell personal health trends to insurance firms and data brokers, FoodLens is built from the ground up as a decentralized, privacy-first platform.

FoodLens does not operate central servers that harvest personal data, does not sell or broker user records, and does not require credit cards or invasive identity profiles.

---

## 2. Zero Telemetry and Zero Data Harvesting

FoodLens strictly adheres to a zero telemetry policy:

- **No Behavioral Tracking**: FoodLens does not track how often you open the app, which features you explore, or what buttons you press.
- **No Third-Party Advertising SDKs**: There are zero ad networks, marketing trackers, or commercial monetization libraries bundled inside FoodLens.
- **No Device Fingerprinting**: We do not collect unique device identifiers, IMEI numbers, MAC addresses, or location data.
- **No Account Requirement for Basic Utilities**: You can use local nutritional references, unit converters, and currency calculations without creating any account.

---

## 3. Decentralized User-Pays Architecture

FoodLens uses a decentralized **User-Pays** computing architecture powered by **Puter.js**:

1. **User-Owned Credentials**: To perform cloud AI vision analysis on meals and packaged food labels, users connect their personal Puter account.
2. **Direct Client-to-Provider Processing**: Your application communicates directly with the decentralized Puter service. FoodLens maintainers operate zero intermediate proxy servers, meaning your food images never pass through developer servers or third-party brokers.
3. **Monthly AI Allowance**: Puter provides each user with a complimentary monthly AI allowance ($10.00 monthly quota). Your consumption is deducted directly from your personal allowance.
4. **Session Independence**: Your credentials remain isolated within your personal authentication session. FoodLens never exposes private tokens in URL query strings or public logs.

---

## 4. Mobile Device Permissions and Usage

FoodLens requests only the minimal Android permissions necessary to provide its core visual food analysis capabilities:

| Permission | Technical Identifier | Purpose | Usage Constraints |
| :--- | :--- | :--- | :--- |
| **Camera** | `android.permission.CAMERA` | Captures food photos, packaged nutrition labels, and dining menus. | Active only while viewfinder screen is open. No background capture or covert recording. |
| **Media / Photos** | `android.permission.READ_MEDIA_IMAGES` | Allows you to select an existing food image from your device gallery. | Reads only the single photo explicitly selected by you. |
| **Internet** | `android.permission.INTERNET` | Transmits image payloads directly to Puter.js for vision inference. | All transmissions use encrypted HTTPS/TLS protocols. |

You can revoke camera or photo gallery permissions at any time through your Android System Settings (`Settings > Apps > FoodLens > Permissions`).

---

## 5. Food Image Processing and Ephemeral Handling

When you scan a meal, packaged food label, or restaurant menu:

1. The image is captured on your device and converted to an ephemeral payload.
2. The payload is transmitted over an encrypted TLS connection directly to Puter.js cloud vision inference (`Claude-3.5 Sonnet` or compatible multimodal model).
3. The AI model analyzes the visual content to estimate ingredients, macronutrients, calories, and potential allergens.
4. A structured JSON response is returned directly to your device and displayed in FoodLens.
5. **No Central Image Retention**: FoodLens maintainers do not store, view, or retain copies of your food imagery.

---

## 6. On-Device Local Storage and Encryption

All persistent application data resides locally on your mobile device inside the application private sandbox:

- **Meal History and Daily Logs**: Logged calories, macronutrients, and water intake.
- **Favorite Recipes and Saved Dishes**: Locally curated dietary entries.
- **Custom Nutritional Targets**: Calorie goals, dietary preferences, and macro ratios.
- **Application Preferences**: Selected language (English, Bengali, Arabic, Spanish, French, German, Japanese, Hindi), script direction, and preferred currency.

This data is stored using Android private preferences and encrypted local storage (`shared_preferences`). It is never synced to a centralized cloud database without your explicit action. Clearing the application data or uninstalling FoodLens permanently deletes all local records.

---

## 7. Third-Party Services

The only third-party service integrated into FoodLens is:

- **Puter.js (`js.puter.com`)**: Provides decentralized cloud storage, authentication, and multimodal AI vision capabilities under the User-Pays paradigm. Puter operates under its own privacy policy and terms of service. For details on how Puter manages account credentials and infrastructure, visit [https://puter.com](https://puter.com).

FoodLens contains **zero** Google Analytics, Firebase Analytics, Meta SDKs, Mixpanel, Segment, Adjust, or AppsFlyer trackers.

---

## 8. International Privacy Rights (GDPR, CCPA, and Global Compliance)

Because FoodLens stores all user data locally on your device:

- **Right to Access**: You have immediate access to all logged meals, nutritional records, and settings directly within the app interface.
- **Right to Rectification**: You can edit or correct any meal record, portion size, or calorie count at any time.
- **Right to Erasure (Right to be Forgotten)**: You can delete individual meal entries, reset your daily logs, or wipe all application data instantly via Android Settings.
- **Right to Data Portability**: Because your data is stored on-device in standard formats, you have physical custody of your information.
- **No Sale of Personal Information**: FoodLens has never sold, rented, or monetized personal information and will never do so.

---

## 9. Children's Privacy

FoodLens is intended for general educational and lifestyle awareness. We do not knowingly solicit or collect personal information from children under the age of 13 (or under 16 in certain jurisdictions). Because the application does not collect user identities, no personal data from minors is harvested.

---

## 10. Open-Source Verification and Auditing

The complete source code of FoodLens is publicly available under the open-source MIT License at [https://github.com/CodeByArnob/FoodLens](https://github.com/CodeByArnob/FoodLens).

Security researchers, developers, and privacy advocates worldwide are encouraged to audit the source code, inspect network traffic, verify our lack of third-party trackers, and contribute enhancements.

---

## 11. Changes to This Privacy Policy

We may update this Privacy Policy periodically to reflect enhancements in application functionality or changes in legal regulations. Any revisions will be documented in our Git commit history and published on this page and our official website:

- Official Website Privacy Policy: [https://codebyarnob.github.io/FoodLens/privacy.html](https://codebyarnob.github.io/FoodLens/privacy.html)
- GitHub Repository Policy: [https://github.com/CodeByArnob/FoodLens/blob/main/PRIVACY.md](https://github.com/CodeByArnob/FoodLens/blob/main/PRIVACY.md)

---

## 12. Contact and Maintainer Information

If you have questions, feedback, or security inquiries regarding this Privacy Policy or FoodLens data practices, please reach out through our official channels:

- **Lead Maintainer**: CodeByArnob (Arnob)
- **GitHub Issues**: [https://github.com/CodeByArnob/FoodLens/issues](https://github.com/CodeByArnob/FoodLens/issues)
- **Discussions**: [https://github.com/CodeByArnob/FoodLens/discussions](https://github.com/CodeByArnob/FoodLens/discussions)
