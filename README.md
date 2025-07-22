# RoseateOS

**An offline-first, privacy-focused productivity app for Android and iOS.**

---

## Overview
RoseateOS is a closed-source, offline-first mobile productivity application built with Flutter. It is designed for individuals who value privacy, personalization, and self-optimization. All user data is stored locally and encrypted (AES-256), with no cloud sync or external data transmission by default.

- **Platforms:** Android & iOS (prioritize Android first)
- **Core Focus:** Privacy, personalization, self-optimization
- **Target Audience:** Users seeking full control over their productivity workflows and data security

---

## Features
- **User Profile & Settings:**
  - Personalized profile (name, age, preferences)
  - Privacy-centric, encrypted local storage
  - Optional 6-digit PIN authentication (user-controlled)
- **Life Dashboard:**
  - Central hub for all productivity tools
  - Seasonal UI themes (Spring, Summer, Fall, Winter; auto/manual)
- **Productivity Tools:**
  - Daily Planner & To-Do List (with reminders/notifications)
  - Calendar & Event Reminders
  - Goal & Target Tracker (visual progress meters)
  - Financial Tracker (offline budgeting)
  - Notes Center, Brain Dump, Idea Vault
  - Business Contact Book
- **Reminders & Notifications:**
  - Offline notifications (alarm/reminder)
  - Recurring reminders (daily, weekly, monthly, custom)
  - Full CRUD for reminders, with encrypted storage
- **Static Content:**
  - About Us, Copyright, Terms & Conditions (see `about_us.md`, `COPYRIGHT.txt`, `t&c.md`)

---

## Architecture
- **Flutter (Dart)**: Cross-platform mobile framework
- **MVC-like Structure:**
  - `lib/models/` – Data models (Hive, encrypted)
  - `lib/controllers/` – Business logic/controllers
  - `lib/services/` – Storage, encryption, notifications
  - `lib/views/` – UI screens (stubbed, ready for UI/UX agent)
  - `lib/themes/` – Seasonal theming
  - `lib/widgets/` – Reusable UI components
- **State Management:**
  - Uses `setState`, can be extended with Provider/Riverpod
- **Local Storage:**
  - Hive (AES-256 encrypted via `EncryptedHiveService`)
  - All user data, reminders, and settings are stored offline
- **Notifications:**
  - `flutter_local_notifications` for offline reminders/alarms
  - Recurring reminders are auto-rescheduled on app startup

---

## Setup & Usage

### 1. Install Dependencies
```sh
flutter pub get
```

### 2. Generate Hive Type Adapters
```sh
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run the App
```sh
flutter run
```

### 4. Build for Release
```sh
# Android
flutter build apk --release
# iOS (on Mac)
flutter build ios --release
```

---

## UI/UX Implementation (for Vertex v0 or other agents)
- All business logic, models, and controllers are implemented and modular.
- UI screens in `lib/views/` are stubbed and ready for replacement/enhancement.
- Use the provided controllers/services for all data access, reminders, and actions.
- Integrate seasonal theming using `SeasonalTheme`.
- See the [UI/UX Implementation Prompts](#uiux-implementation-for-vertex-v0) below for step-by-step guidance.

---

## UI/UX Implementation for Vertex v0

1. Replace stub UIs in `lib/views/` with modern, responsive Flutter widgets.
2. Use controllers/services for all CRUD and notification actions.
3. Integrate seasonal theming and settings.
4. Ensure all flows (reminders, PIN, settings, dashboard) are visually consistent and accessible.
5. Test on both Android and iOS.

---

## Data Privacy & Security
- All user data is stored locally and encrypted (AES-256).
- No data is transmitted externally unless user opts in for backup (not implemented by default).
- PIN authentication is optional and user-controlled.
- All reminders/notifications are handled offline.

---

## Static Content
- **About Us:** See `about_us.md`
- **Copyright:** See `COPYRIGHT.txt`
- **Terms & Conditions:** See `t&c.md`

---

## Developer & Contact
- **Developer:** Farish Aqasha (Zakyasshii Technologies)
- **Contact:** zakyasshii@gmail.com | [@zakyashii](https://instagram.com/zakyashii)

---

## License
RoseateOS is closed-source and proprietary. All rights reserved © 2025 Farish Aqasha (Zakyasshii Technologies).

---

## Acknowledgements
- Built with Flutter, Hive, and flutter_local_notifications.
- UI/UX to be completed by Vertex v0 AI agent or other design tools.
