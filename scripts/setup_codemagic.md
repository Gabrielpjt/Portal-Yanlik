# 🚀 Quick Setup Checklist

Ikuti checklist ini untuk setup iOS build via Codemagic dari Windows.

## ✅ Phase 1: Preparation (5 menit)

### 1.1 Verify Files
```bash
# Check codemagic.yaml exists
dir codemagic.yaml

# Check iOS folder exists  
dir ios\Runner.xcodeproj
```

✅ Files ready

### 1.2 Update Project Info

Edit file: `ios/Runner/Info.plist`

Pastikan ada:
- `CFBundleName`: Portal Layanan Publik
- `CFBundleDisplayName`: Portal Layanan
- `CFBundleVersion`: 1.0.0

### 1.3 Test Local Build (Android)

```bash
# Pastikan app jalan di Android/Web dulu
flutter clean
flutter pub get
flutter run -d chrome
```

## ✅ Phase 2: GitHub Setup (5 menit)

### 2.1 Push to GitHub

```bash
# Check git status
git status

# Add all files
git add .
git commit -m "Setup iOS build configuration with Codemagic"

# Push to GitHub (ubah URL dengan repo Anda)
git remote add origin https://github.com/USERNAME/portal-layanan-publik-mobile.git
git branch -M main
git push -u origin main
```

### 2.2 Verify on GitHub

Buka https://github.com/USERNAME/portal-layanan-publik-mobile

✅ Pastikan file `codemagic.yaml` terlihat di root

## ✅ Phase 3: Codemagic Account (10 menit)

### 3.1 Sign Up

1. Buka https://codemagic.io/signup
2. **Sign up with GitHub** (recommended)
3. Authorize Codemagic access

### 3.2 Add Application

1. Klik **"Add application"**
2. Pilih **"Connect GitHub repository"**
3. Search: `portal-layanan-publik-mobile`
4. Klik **"Select"**
5. Project type: **"Flutter App"**
6. Finish setup

✅ App connected to Codemagic

### 3.3 Configure Workflow

1. Klik app name → **"Start your first build"**
2. **JANGAN** klik Start dulu
3. Klik **"Workflow editor"** (tab)
4. Check apakah Codemagic detect `codemagic.yaml`
5. Jika tidak detect, pilih **"Add workflow from codemagic.yaml"**

✅ Workflow configured

## ✅ Phase 4: Apple Developer Setup (15 menit)

⚠️ **Required: Apple Developer Account ($99/year)**

### 4.1 Apple Developer Account

1. Buka https://developer.apple.com
2. Sign in / Register
3. Enroll di Apple Developer Program ($99/year)
4. Tunggu approval (~1-2 hari)

### 4.2 Connect to Codemagic

Di Codemagic dashboard:

1. Klik **Teams** (sidebar) → **Integrations**
2. Scroll ke **"App Store Connect"**
3. Klik **"Connect"**
4. Masukkan:
   - **Apple ID**: your-email@example.com
   - **App-specific password**: (generate dulu)

**Generate App-Specific Password:**
1. Buka https://appleid.apple.com
2. Sign in
3. **Security** section
4. **App-Specific Passwords** → **Generate**
5. Name: "Codemagic"
6. Copy password (hanya muncul sekali!)
7. Paste di Codemagic

✅ Apple account connected

### 4.3 Register Bundle ID

1. Buka https://developer.apple.com/account
2. **Certificates, Identifiers & Profiles**
3. **Identifiers** → **(+)** button
4. Pilih **"App IDs"** → Continue
5. Pilih **"App"** → Continue
6. Fill form:
   - **Description**: Portal Layanan Publik Mobile
   - **Bundle ID**: Explicit
   - **Bundle ID String**: `com.kominfo.portallayananpublik`
7. **Capabilities**: Check yang dibutuhkan (default OK)
8. **Continue** → **Register**

✅ Bundle ID registered

## ✅ Phase 5: First Build (10 menit)

### 5.1 Start Debug Build (No Signing)

Untuk testing pertama, gunakan workflow debug:

1. Di Codemagic app page
2. **Start new build** button
3. Pilih workflow: **"ios-debug-workflow"**
4. Branch: **"main"**
5. Klik **"Start build"**

Wait ~5-10 menit...

### 5.2 Monitor Build

- Watch logs real-time
- Check setiap step (hijau = success)
- Tunggu sampai selesai

✅ Build success / Check logs jika fail

### 5.3 Troubleshooting

**Jika build FAILED:**

1. Baca error di logs
2. Common issues:
   - **Flutter dependencies**: Run `flutter pub get`
   - **Pods issue**: Check Podfile
   - **Syntax error**: Check codemagic.yaml format

**Get Help:**
- Check: docs/IOS_BUILD_SETUP.md
- Codemagic support: https://codemagic.io/support

## ✅ Phase 6: Production Build (15 menit)

⚠️ Hanya setelah debug build success

### 6.1 Setup Code Signing

Di Codemagic:

1. App → **Workflow settings**
2. Pilih workflow: **"ios-workflow"**
3. **Code signing** section
4. Enable **"Automatic code signing"**
5. Pilih Apple Developer account
6. Save

### 6.2 Start Production Build

1. **Start new build**
2. Workflow: **"ios-workflow"**
3. Branch: **"main"**
4. **Start build**

Wait ~10-15 menit...

✅ IPA file generated

### 6.3 Download IPA

1. Build finished → **Artifacts** tab
2. Download `app-release.ipa`
3. File size ~50-100 MB

✅ iOS app ready!

## ✅ Phase 7: TestFlight Upload (10 menit)

### 7.1 Auto Upload

Jika sudah configure di `codemagic.yaml`:

```yaml
publishing:
  app_store_connect:
    submit_to_testflight: true
```

Build akan auto-upload ke TestFlight! ✅

### 7.2 Invite Testers

1. Buka https://appstoreconnect.apple.com
2. **My Apps** → **TestFlight**
3. Pilih build terbaru
4. **Internal Testing** atau **External Testing**
5. **Add Testers** → Masukkan email
6. Tester akan dapat invite via email

### 7.3 Test di iPhone

Tester:
1. Install app **TestFlight** dari App Store
2. Open email invite → Tap link
3. Tap **"Install"** di TestFlight
4. Test app! 🎉

✅ App tested on real iPhone

## 🎊 DONE!

Selamat! iOS app berhasil di-build dari Windows tanpa Mac.

### 📊 Summary

- ✅ Codemagic configured
- ✅ Apple Developer connected  
- ✅ iOS build success
- ✅ IPA generated
- ✅ TestFlight uploaded
- ✅ App tested

### 🔄 Next Builds

Setiap push ke `main` akan auto-trigger build:

```bash
# Make changes
git add .
git commit -m "Update feature"
git push origin main
# → Codemagic auto-builds! 🚀
```

### 📈 Monitoring

- Codemagic dashboard: https://codemagic.io/apps
- Email notifications (success/failure)
- Slack integration (optional)

### 💰 Build Minutes

Free tier: **500 minutes/month**
- ~25 iOS builds
- Upgrade jika perlu lebih

---

**Need Help?**
- 📖 [Full Documentation](docs/IOS_BUILD_SETUP.md)
- 💬 [Codemagic Support](https://codemagic.io/support)
- 🐛 [Report Issues](https://github.com/USERNAME/repo/issues)

Happy Building! 🚀🍎
