# 🍎 Setup iOS Build di Windows (Tanpa Mac)

Guide lengkap untuk build iOS app dari Windows menggunakan Codemagic CI/CD.

## 📋 Prerequisites

1. **Apple Developer Account** ($99/tahun)
   - Diperlukan untuk code signing dan publish ke App Store
   - Daftar di: https://developer.apple.com

2. **GitHub Account** (gratis)
   - Repository sudah harus di GitHub
   - Codemagic akan connect ke GitHub repo

3. **Codemagic Account** (gratis)
   - Free tier: 500 build minutes/bulan
   - Daftar di: https://codemagic.io

## 🚀 Langkah-langkah Setup

### 1. Push Repository ke GitHub

```bash
# Jika belum ada remote GitHub
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/USERNAME/portal-layanan-publik-mobile.git
git push -u origin main
```

### 2. Setup Codemagic

#### A. Daftar dan Connect Repository

1. Buka https://codemagic.io/signup
2. Login dengan GitHub account
3. Klik **Add application**
4. Pilih repository: `portal-layanan-publik-mobile`
5. Pilih **Flutter App** sebagai project type

#### B. Connect Apple Developer Account

1. Di Codemagic dashboard, klik **Teams** → **Integrations**
2. Klik **Connect** di bagian **App Store Connect**
3. Ikuti wizard:
   - Masukkan **Apple ID** (developer account)
   - Generate **App-Specific Password**:
     - Buka https://appleid.apple.com
     - Sign in → Security → App-Specific Passwords
     - Generate password baru untuk "Codemagic"
   - Copy password dan paste di Codemagic

#### C. Setup Code Signing

**Otomatis (Recommended):**

1. Codemagic akan otomatis manage certificates & provisioning profiles
2. Pastikan setting di `codemagic.yaml`:
   ```yaml
   ios_signing:
     distribution_type: app_store
     bundle_identifier: com.kominfo.portallayananpublik
   ```

**Manual (Advanced):**

1. Download certificates dari Apple Developer Portal
2. Upload ke Codemagic → Code signing identities
3. Link dengan Bundle ID

### 3. Konfigurasi Bundle ID

#### Update iOS Bundle ID:

1. Buka `ios/Runner.xcodeproj/project.pbxproj`
2. Atau edit langsung di Codemagic:

```yaml
# Di codemagic.yaml
vars:
  BUNDLE_ID: "com.kominfo.portallayananpublik"
```

Atau ubah sesuai kebutuhan:
```
com.yourcompany.portallayananpublik
```

### 4. Run First Build

#### Via Codemagic UI:

1. Buka app di Codemagic dashboard
2. Pilih workflow: `ios-workflow`
3. Klik **Start new build**
4. Pilih branch: `main`
5. Klik **Start build**

#### Via Git Push:

```bash
# Otomatis trigger build setiap push ke main
git add .
git commit -m "Setup iOS build"
git push origin main
```

Build akan jalan ~10-15 menit pertama kali.

### 5. Monitoring Build

1. Lihat logs real-time di Codemagic dashboard
2. Check notifikasi email (success/failure)
3. Download `.ipa` file dari artifacts jika sukses

## 🔧 Troubleshooting

### ❌ Build Failed: Code Signing Error

**Solusi:**
```yaml
# Gunakan workflow debug dulu untuk testing
# File: codemagic.yaml
workflows:
  ios-debug-workflow:
    # Build tanpa code signing
```

Run workflow:
```bash
# Pilih ios-debug-workflow di Codemagic UI
```

### ❌ Bundle ID Already Exists

**Solusi:**
1. Ubah Bundle ID di `codemagic.yaml`
2. Atau claim Bundle ID di Apple Developer Portal

### ❌ Apple Developer Account Required

**Solusi:**
- iOS requires paid developer account ($99/year)
- Tidak bisa bypass untuk real device testing & App Store
- Alternatif: Test di Android dulu

## 📱 Testing iOS Build

### Option 1: TestFlight (Recommended)

Setelah build sukses, app otomatis upload ke TestFlight:

1. Install **TestFlight** app di iPhone
2. Invite tester via Apple Developer Portal
3. Open invite link di iPhone
4. Download & test app

### Option 2: Download IPA

1. Download `.ipa` dari Codemagic artifacts
2. Install ke device via:
   - **Diawi**: https://www.diawi.com (upload IPA, dapat link)
   - **iOS App Signer**: untuk re-sign IPA
   - **Xcode Devices**: jika punya akses Mac

## 🎯 Workflow yang Tersedia

### 1. `ios-workflow` - Production Build
- Build release dengan code signing
- Upload ke TestFlight otomatis
- Requires: Apple Developer Account

### 2. `ios-debug-workflow` - Quick Testing
- Build debug tanpa signing
- Untuk validasi kode saja
- Tidak bisa install ke device

### 3. `android-workflow` - Android Build
- Build AAB untuk Play Store
- Parallel dengan iOS build

## 💰 Codemagic Pricing

**Free Tier:**
- 500 build minutes/bulan
- Unlimited team members
- Cukup untuk ~25 iOS builds

**Paid Plans:**
- Jika perlu lebih banyak builds
- Mulai $99/month

## 🔐 Environment Variables (Optional)

Untuk menyimpan secrets:

```yaml
# Di Codemagic UI: App settings → Environment variables
environment:
  vars:
    API_KEY: "your-api-key"
    BASE_URL: "https://api.example.com"
```

Access di code:
```dart
const apiKey = String.fromEnvironment('API_KEY');
```

## 📚 Resources

- [Codemagic Documentation](https://docs.codemagic.io/flutter-configuration/flutter-projects/)
- [Apple Developer Portal](https://developer.apple.com)
- [TestFlight Guide](https://developer.apple.com/testflight/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)

## 🆘 Need Help?

1. Check build logs di Codemagic
2. Codemagic support: https://codemagic.io/support
3. Flutter iOS issues: https://github.com/flutter/flutter/issues

## ✅ Checklist Setup

- [ ] Repository pushed ke GitHub
- [ ] Codemagic account dibuat
- [ ] Repository connected ke Codemagic
- [ ] Apple Developer Account connected
- [ ] Bundle ID dikonfigurasi
- [ ] `codemagic.yaml` ada di root project
- [ ] First build berhasil
- [ ] IPA file ter-generate
- [ ] TestFlight invite sent
- [ ] App tested di real iPhone

---

**Happy Building! 🚀**
