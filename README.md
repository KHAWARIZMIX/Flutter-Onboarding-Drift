
# 👤 Flutter Onboarding Drift

A basic Flutter onboarding app that allows users to create a profile with a name and profile picture. Built using:

* 🧠 **Riverpod** for state management
* 💾 **Drift**: A powerful local database toolkit for Flutter, used here for efficient data persistence.
* 📸 **Image Picker** for selecting profile images

---

## 🚀 Features

* Clean and simple onboarding flow
* Profile image selection via gallery
* Local user data storage with Drift
* Responsive and modular code with Riverpod
* Ready-to-use architecture for user-driven apps

---

## 📷 Preview

> *(Add screenshots or a GIF of the onboarding flow here)*

---

## 🛠️ Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/KHAWARIZMIX/flutter-onboarding-drift.git
cd flutter-onboarding-drift
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Generate Drift files

```bash
flutter pub run build_runner build
# or
dart run build_runner build --delete-conflicting-outputs
```

> ⚠️ Use `build_runner watch` for automatic rebuilds during development.

### 4. Run the app

```bash
flutter run
```

---

## 📦 Dependencies

| Package                | Purpose                                         |
| ---------------------- | ----------------------------------------------- |
| `flutter_riverpod`     | State management                                |
| `drift`                | Local relational database                       |
| `drift_dev`            | Code generator for Drift                        |
| `sqlite3_flutter_libs` | Native SQLite libraries for Flutter             |
| `image_picker`         | Pick image from gallery or camera               |
| `intl`                 | Date/time formatting and localization           |
| `path`                 | Utilities for manipulating file paths           |
| `path_provider`        | Access device directories (cache, app doc, etc) |

---

## 📁 Project Structure

```
lib/
├── main.dart
├── models/           # Drift data models & tables
├── providers/        # Riverpod providers
├── screens/          # Onboarding & home screens
└── widgets/          # Reusable UI components
```

---

## ✅ Requirements

* Flutter SDK (latest stable)
* Dart SDK
* Android Studio or VS Code
* Android or iOS emulator/device

---

## 📄 License

[MIT](LICENSE)

---

If you want, I can help you generate this as a markdown file or add badges and links!
