# RoseateOS

**An offline-first, privacy-focused productivity app for Android and iOS (Android prioritized).**

RoseateOS stores all user data locally with AES-256 encrypted Hive boxes. There is no cloud login, no Supabase, and no network sync by default.

---

## What the app does

- **First launch:** Accept terms, create a local profile, then open the Life Dashboard.
- **Return visits:** Open the dashboard directly, or the PIN lock screen when PIN protection is enabled.
- **Optional fingerprint unlock:** Enable in Settings → PIN Lock Settings (requires PIN to be enabled first).
- **Life Dashboard:** Entry point to planner, calendar, goals, finance, notes, and business contacts.
- **Business contacts:** Full encrypted local CRUD (name, company, phone, email).
- **Reminders:** Offline local notifications via `flutter_local_notifications`.
- **Seasonal themes:** Spring, Summer, Fall, Winter (auto by date; manual override in Settings).

Static copy: `about_us.md`, `COPYRIGHT.txt`, `t&c.md`.

---

## Architecture

| Layer | Path | Role |
|-------|------|------|
| Models | `lib/models/` | Hive types (profile, contacts, reminders, …) |
| Controllers | `lib/controllers/` | Feature logic and encrypted box access |
| Services | `lib/services/` | Storage, PIN/biometrics, notifications |
| Views | `lib/views/` | Flutter UI screens |
| Themes | `lib/themes/` | Seasonal theming |

**Startup routing** (`lib/main.dart`):

1. No local profile → `FirstLaunchScreen`
2. Profile + PIN enabled → `PinLockScreen` (PIN or optional fingerprint)
3. Otherwise → `DashboardScreen`

---

## Prerequisites

- [Flutter](https://docs.flutter.dev/get-started/install) **3.44.0** (matches CI)
- Android SDK (API 23+ for biometrics)
- For iOS builds: macOS with Xcode

---

## Setup

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## Run (debug)

```sh
flutter run
```

---

## Release build

```sh
# Android APK
flutter build apk --release

# iOS (on macOS)
flutter build ios --release
```

Release APK output: `build/app/outputs/flutter-apk/app-release.apk`

Latest verified Android APK: [`RoseateOS.apk`](https://drive.google.com/file/d/1wTG4ZVU6Z1vZBqM_VxBaqZnfyW2hwd3z/view?usp=drivesdk)

The release APK is built by GitHub Actions from `main` using Flutter 3.44.0 and uploaded to Drive for reviewer installation.

---

## CI

GitHub Actions (`.github/workflows/android-release.yml`) builds a release APK on push/PR to `main` using Flutter 3.44.0 and uploads the APK as an artifact.

---

## Privacy & security

- Data stays on device; encrypted Hive boxes via `EncryptedHiveService`.
- Optional 6-digit PIN (`PinService` + `flutter_secure_storage`).
- Optional biometric unlock (`local_auth`) when PIN is enabled.
- No account system and no remote backend in this repository.

---

## Developer

**Farish Aqasha (Zakyasshii's Technologies)**
zakyasshii@gmail.com · [@zakyashii](https://instagram.com/zakyashii)

---

## License

RoseateOS is closed-source and proprietary. All rights reserved © 2025 Farish Aqasha (Zakyasshii's Technologies).
