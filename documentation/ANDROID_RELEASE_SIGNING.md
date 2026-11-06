# FoodLens Android release signing

FoodLens must use one stable private upload/release keystore for production APKs and future Play Store uploads. Never commit the keystore, passwords, or `key.properties` to Git.

## 1. Generate the keystore on your own computer

Use JDK 17's `keytool`. Run PowerShell:

```powershell
keytool -genkeypair -v -keystore "$env:USERPROFILE\foodlens-upload-key.jks" -alias foodlens-upload -keyalg RSA -keysize 4096 -validity 10000
```

Choose a strong unique keystore password and key password when prompted. Store both in a reputable password manager. Keep at least two encrypted offline backups of the JKS file. Do not send the JKS file or passwords in chat, email, or a GitHub issue.

**Important:** Losing this key can prevent future direct APK updates. If you later publish through Google Play App Signing, the Play app-signing certificate and upload certificate have different roles. The Android App Links fingerprint must match the certificate that signs the installed app.

## 2. Configure local release builds

Create `android/key.properties` locally. This file is ignored by Git:

```properties
storeFile=C:/Users/YOUR_WINDOWS_USER/foodlens-upload-key.jks
storePassword=YOUR_KEYSTORE_PASSWORD
keyAlias=foodlens-upload
keyPassword=YOUR_KEY_PASSWORD
```

Use your actual Windows username and passwords. Do not add quotes around values. Do not commit this file.

Build:

```powershell
flutter build apk --release
```

Without a valid `android/key.properties`, a production release build intentionally fails. The CI verification workflow explicitly opts into a temporary debug-signed APK; that artifact is for build verification only and must never be distributed as a production release.

## 3. Read the public SHA-256 certificate fingerprint

Run:

```powershell
keytool -list -v -keystore "$env:USERPROFILE\foodlens-upload-key.jks" -alias foodlens-upload
```

Enter the password when prompted. Copy only the `SHA256:` fingerprint for the certificate. It is public certificate metadata, not a secret. Share only that fingerprint when we configure Android Digital Asset Links.

## 4. Protect GitHub Actions release secrets

For automated production signing, add these repository Actions secrets under **Settings → Secrets and variables → Actions**:

- `FOODLENS_KEYSTORE_BASE64`: one-line Base64 encoding of the JKS file.
- `FOODLENS_KEYSTORE_PASSWORD`: keystore password.
- `FOODLENS_KEY_ALIAS`: `foodlens-upload` (or the alias you selected).
- `FOODLENS_KEY_PASSWORD`: key password.

Generate the Base64 value in PowerShell without printing the binary:

```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("$env:USERPROFILE\foodlens-upload-key.jks")) | Set-Clipboard
```

Paste the clipboard value directly into the GitHub secret form. Never put the Base64 value in a source file, commit, issue, or chat. Do not create these secrets until the local keystore and backup are safely stored.

The current CI workflow does not consume production signing secrets. It builds a clearly identified debug-signed verification artifact only. Production signing automation should be enabled separately after the keystore is safely created and the secrets are configured.

## 5. Key safety rules

- Never regenerate or replace this keystore after releasing an APK without a deliberate signing-key migration plan.
- Never use the CI debug certificate for Android App Links.
- Never publish `key.properties`, `.jks`, `.keystore`, passwords, or Base64 keystore material.
- Keep the SHA-256 fingerprint separate from the private key. The fingerprint can be used in the public `assetlinks.json` file.
