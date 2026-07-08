# Portal Layanan Publik Mobile

Aplikasi mobile untuk mengakses layanan publik pemerintah dengan mudah.

> 🍎 **Windows Users:** Build iOS tanpa Mac! Lihat [iOS Quick Start Guide](IOS_QUICK_START.md) (5 menit setup)

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.44.1+
- Dart SDK 3.6.0+
- Android Studio / VS Code

### Installation

```bash
# Clone repository
git clone [repository-url]
cd portal_layanan_publik_mobile

# Install dependencies
flutter pub get

# Run app (Android/Web)
flutter run

# Run on specific device
flutter run -d chrome       # Web
flutter run -d emulator-id  # Android emulator
```

### 🍎 iOS Build dari Windows

Karena iOS memerlukan macOS, kami menggunakan **Codemagic CI/CD** untuk build iOS dari Windows:

1. **Quick Start**: Lihat [📱 iOS Build Setup Guide](docs/IOS_BUILD_SETUP.md)
2. **Requirements**:
   - Apple Developer Account ($99/tahun)
   - GitHub Account (gratis)
   - Codemagic Account (gratis - 500 build minutes/bulan)

**Workflow Tersedia:**
- `ios-workflow` - Production build + TestFlight upload
- `ios-debug-workflow` - Quick validation tanpa signing
- `android-workflow` - Android build parallel

Build otomatis trigger setiap push ke `main` branch.

## 📱 Features

- **Home**: Pencarian layanan, layanan populer, topik trending
- **Search**: Pencarian layanan (dalam pengembangan)
- **Services**: Daftar kategori layanan lengkap
- **Profile**: Profil pengguna (dalam pengembangan)

## 🏗️ Project Structure

```
lib/
├── app/              # Konfigurasi app (theme, router)
├── core/             # Utility & reusable widgets
├── features/         # Feature modules
│   ├── home/
│   ├── search/
│   ├── services/
│   └── profile/
└── shared/           # Shared models & types
```

## 🎨 Tech Stack

- **Flutter**: 3.44.1+
- **Architecture**: Feature-First + Clean Architecture
- **State Management**: StatefulWidget (akan upgrade ke Riverpod)

## 📝 Development

### Run Commands

```bash
# Development (Android/Web)
flutter run
flutter run -d chrome  # Web

# Build Android
flutter build apk --release
flutter build appbundle --release  # For Play Store

# Build iOS (requires Mac OR use Codemagic)
flutter build ios --release  # Local Mac only
# For Windows: Push to GitHub → Codemagic auto-builds

# Run tests
flutter test

# Analyze code
flutter analyze
```

### Adding Logo

Letakkan file `LOGO_INAKU.png` di folder `assets/images/`

## 📚 Documentation

### iOS Build (Windows)
- 📱 [iOS Build Setup Summary](docs/IOS_SETUP_SUMMARY.md) - Quick overview
- 📖 [Complete Setup Guide](docs/IOS_BUILD_SETUP.md) - Detailed instructions
- 📋 [Step-by-Step Checklist](scripts/setup_codemagic.md) - Follow along
- 🔧 [Bundle ID Configuration](docs/BUNDLE_ID_SETUP.md) - App identifier setup
- 🎬 [Appetize.io Demo Setup](docs/APPETIZE_SETUP.md) - Browser-based iOS demo

### Project Documentation
- Structure overview
- Development guide
- Widget usage examples

## 👥 Team

Developed by Kementerian Komunikasi dan Informatika

## 📄 License

[Your License Here]
