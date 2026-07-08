# 📱 iOS Build Setup - Quick Summary

Ringkasan setup iOS build dari Windows menggunakan Codemagic CI/CD.

## 🎯 Yang Sudah Disiapkan

✅ **Configuration Files:**
- `codemagic.yaml` - Workflow definitions (iOS & Android)
- `ios/Runner/Info.plist` - App metadata
- Documentation lengkap di `docs/`

✅ **Workflows Available:**
1. **ios-workflow** - Production build + TestFlight upload
2. **ios-debug-workflow** - Quick test tanpa code signing
3. **android-workflow** - Android parallel build

✅ **Documentation:**
- 📖 `docs/IOS_BUILD_SETUP.md` - Full setup guide
- 📋 `scripts/setup_codemagic.md` - Step-by-step checklist
- 🔧 `docs/BUNDLE_ID_SETUP.md` - Bundle ID configuration

## 🚀 Quick Start (10 menit)

### 1. Push to GitHub
```bash
git add .
git commit -m "Setup iOS build with Codemagic"
git push origin main
```

### 2. Setup Codemagic
1. Sign up: https://codemagic.io/signup (with GitHub)
2. Add application → Select this repo
3. Codemagic auto-detect `codemagic.yaml`

### 3. Connect Apple Developer
1. Codemagic → Teams → Integrations
2. Connect App Store Connect
3. Generate app-specific password di appleid.apple.com

### 4. Start Build
1. Pilih `ios-debug-workflow` (untuk testing pertama)
2. Start build
3. Wait ~5-10 menit
4. Download IPA dari artifacts

## 💰 Requirements & Costs

| Item | Cost | Notes |
|------|------|-------|
| **Codemagic Free Tier** | FREE | 500 build minutes/month (~25 builds) |
| **Apple Developer** | $99/year | Required untuk TestFlight & App Store |
| **GitHub** | FREE | Public repo |

## 📊 Build Process Flow

```
1. Git Push
   ↓
2. Codemagic Detects Push
   ↓
3. Start Mac VM
   ↓
4. Install Flutter + Dependencies
   ↓
5. Run flutter build ios
   ↓
6. Code Signing (if production)
   ↓
7. Generate IPA
   ↓
8. Upload to TestFlight (optional)
   ↓
9. Notify via Email
```

**Build Time:** ~10-15 menit untuk iOS

## 🔄 Automatic Triggers

Build otomatis jalan saat:
- ✅ Push ke branch `main`
- ✅ Pull Request created/updated
- ✅ Git tag created (release)

Atau manual trigger via Codemagic UI.

## 📱 Testing Options

### Option 1: TestFlight (Recommended)
- Auto-upload configured di `codemagic.yaml`
- Invite tester via App Store Connect
- Test di real iPhone

### Option 2: Direct IPA Install
- Download IPA dari Codemagic artifacts
- Upload ke https://www.diawi.com
- Share link ke tester

### Option 3: Simulator (Requires Mac)
- Download `.app` build
- Run di Xcode Simulator

## 🎛️ Configuration Variables

Edit di `codemagic.yaml`:

```yaml
environment:
  vars:
    BUNDLE_ID: "com.kominfo.portallayananpublik"  # Change this
    XCODE_WORKSPACE: "Runner.xcworkspace"
    XCODE_SCHEME: "Runner"
  flutter: stable    # or specific version: 3.44.1
  xcode: latest      # or specific: 15.0
```

## 🔐 Bundle ID

**Current:** `com.kominfo.portallayananpublik`

**Change if needed:**
1. Edit `codemagic.yaml`
2. Register di Apple Developer Portal
3. Rebuild

**Naming convention:**
- Format: `com.organization.appname`
- Lowercase only
- Must be unique globally

## 🐛 Common Issues & Solutions

### ❌ "No Apple Developer Account"
**Solution:** Enroll di developer.apple.com ($99/year required)

### ❌ "Code signing error"
**Solution:** Use `ios-debug-workflow` first (no signing)

### ❌ "Bundle ID already registered"
**Solution:** Change Bundle ID di `codemagic.yaml`

### ❌ "Build timeout"
**Solution:** Check logs, mungkin dependencies issue. Run `flutter pub get` locally.

### ❌ "Pod install failed"
**Solution:** Check `ios/Podfile`, remove `ios/Podfile.lock`, rebuild

## 📈 Build Monitoring

### Codemagic Dashboard
- Real-time logs
- Build history
- Artifacts download
- Build statistics

### Email Notifications
Configured di `codemagic.yaml`:
```yaml
publishing:
  email:
    recipients:
      - your-email@example.com
    notify:
      success: true
      failure: true
```

### Slack Integration (Optional)
Add di Codemagic → Integrations → Slack

## 📚 Next Steps

After first successful build:

1. **Setup Automatic Deployment**
   - Enable TestFlight auto-upload
   - Configure beta tester groups

2. **Add Environment Variables**
   - API keys
   - Base URLs
   - Feature flags

3. **Setup Release Process**
   - Version bump automation
   - Changelog generation
   - Git tagging

4. **Optimize Build**
   - Cache dependencies
   - Parallel builds (iOS + Android)
   - Build time optimization

## 🔗 Useful Links

- [Codemagic Dashboard](https://codemagic.io/apps)
- [Apple Developer](https://developer.apple.com)
- [App Store Connect](https://appstoreconnect.apple.com)
- [TestFlight](https://developer.apple.com/testflight/)
- [Flutter iOS Docs](https://docs.flutter.dev/deployment/ios)

## 📞 Support

- 📖 Full Guide: `docs/IOS_BUILD_SETUP.md`
- 📋 Checklist: `scripts/setup_codemagic.md`
- 💬 Codemagic Support: https://codemagic.io/support
- 🐛 Report Issues: GitHub Issues

---

## ✅ Pre-flight Checklist

Before starting setup:

- [ ] Flutter project runs locally (Android/Web)
- [ ] Repository pushed to GitHub
- [ ] Apple Developer Account enrolled ($99/year)
- [ ] Codemagic account created (free)
- [ ] Read `docs/IOS_BUILD_SETUP.md`

**Ready?** Follow `scripts/setup_codemagic.md` step-by-step! 🚀

---

**Estimated Setup Time:**
- Account setup: ~15 menit
- First build: ~10 menit
- TestFlight setup: ~10 menit
- **Total: ~35 menit** ⏱️

**Happy Building! 🎉**
