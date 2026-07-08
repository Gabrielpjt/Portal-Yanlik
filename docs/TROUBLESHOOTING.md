# 🔧 Troubleshooting iOS Build

Common issues dan solusinya saat build iOS dari Windows via Codemagic.

## 🚨 Build Failures

### ❌ "Flutter dependencies resolution failed"

**Error:**
```
Running "flutter pub get" in portal_layanan_publik_mobile...
Error: Unable to resolve dependencies
```

**Solution:**
```bash
# Local test dulu
flutter clean
flutter pub get

# Check pubspec.yaml syntax
flutter pub get --verbose
```

Fix, commit, push:
```bash
git add pubspec.yaml
git commit -m "Fix dependencies"
git push origin main
```

---

### ❌ "Pod install failed"

**Error:**
```
[!] CocoaPods could not find compatible versions for pod "xxx"
```

**Solution 1 - Update Pods:**
```bash
# If you have Mac access
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
```

**Solution 2 - Via Codemagic:**
Edit `codemagic.yaml`:
```yaml
scripts:
  - name: Clean pods
    script: |
      cd ios
      rm -rf Pods Podfile.lock
  - name: Install pods
    script: |
      find . -name "Podfile" -execdir pod install --repo-update \;
```

---

### ❌ "Code signing error"

**Error:**
```
error: No profiles for 'com.kominfo.portallayananpublik' were found
```

**Solution:**

**Option 1 - Use Debug Workflow** (No signing required):
```yaml
# Run: ios-debug-workflow instead of ios-workflow
```

**Option 2 - Setup Apple Developer:**
1. Enroll di https://developer.apple.com ($99/year)
2. Register Bundle ID di Developer Portal
3. Connect Apple account di Codemagic
4. Enable automatic code signing

---

### ❌ "Build timeout"

**Error:**
```
Build exceeded maximum duration of 120 minutes
```

**Solution:**

Edit `codemagic.yaml`:
```yaml
workflows:
  ios-workflow:
    max_build_duration: 120  # Increase if needed (max 240)
```

Or optimize build:
```yaml
scripts:
  - name: Cache Flutter
    script: |
      flutter precache --ios
```

---

### ❌ "Xcode version issue"

**Error:**
```
error: Could not find or use auto-linked library 'swiftCompatibility56'
```

**Solution:**

Specify Xcode version di `codemagic.yaml`:
```yaml
environment:
  xcode: 15.0      # or latest, 14.3, etc.
```

Check available versions: https://docs.codemagic.io/specs/versions-macos/

---

## 🔐 Code Signing Issues

### ❌ "No certificates found"

**Problem:** Codemagic tidak bisa akses Apple certificates.

**Solution:**

1. **Verify Apple Connection:**
   - Codemagic → Teams → Integrations
   - App Store Connect status = Connected ✓

2. **Enable Automatic Signing:**
   ```yaml
   environment:
     ios_signing:
       distribution_type: app_store
       bundle_identifier: com.kominfo.portallayananpublik
   ```

3. **Manual Certificates (Advanced):**
   - Download from Apple Developer Portal
   - Upload to Codemagic → Code signing identities

---

### ❌ "Provisioning profile not found"

**Solution:**

Let Codemagic manage automatically:
```yaml
scripts:
  - name: Set up code signing
    script: |
      xcode-project use-profiles
```

Or create manually:
1. Apple Developer → Certificates, Identifiers & Profiles
2. Profiles → (+) → App Store
3. Select Bundle ID + Certificate
4. Download + upload ke Codemagic

---

## 🍎 Apple Developer Issues

### ❌ "Apple ID verification failed"

**Problem:** Codemagic tidak bisa login ke Apple account.

**Solution:**

Generate App-Specific Password:
1. https://appleid.apple.com
2. Sign in
3. Security → App-Specific Passwords
4. Generate password untuk "Codemagic"
5. Copy password (only shown once!)
6. Update di Codemagic Integrations

---

### ❌ "Bundle ID already registered"

**Error:**
```
An App ID with Identifier 'com.kominfo.portallayananpublik' is not available
```

**Solution:**

**Option 1 - Use Different Bundle ID:**
```yaml
# codemagic.yaml
environment:
  vars:
    BUNDLE_ID: "com.kominfo.portallayanan.mobile"
```

**Option 2 - Transfer Existing:**
If you own the Bundle ID di different account, transfer it.

---

### ❌ "Team ID not found"

**Solution:**

Find your Team ID:
1. https://developer.apple.com/account
2. Membership → Team ID (10 characters)
3. Add to `codemagic.yaml`:
   ```yaml
   environment:
     vars:
       TEAM_ID: "XXXXXXXXXX"
   ```

---

## 📱 TestFlight Issues

### ❌ "Upload to TestFlight failed"

**Error:**
```
ERROR ITMS-90XXX: Invalid something...
```

**Solution:**

Check build settings:
```yaml
scripts:
  - name: Build ipa
    script: |
      flutter build ipa --release \
        --export-options-plist=ios/ExportOptions.plist
```

Common invalid issues:
- **Invalid Bundle ID**: Must match registered
- **Invalid Version**: Use semantic versioning (1.0.0)
- **Missing Icons**: Check `ios/Runner/Assets.xcassets`
- **Missing Privacy**: Add NSXxx keys to Info.plist

---

### ❌ "No testers invited"

**Solution:**

1. https://appstoreconnect.apple.com
2. TestFlight → Internal Testing
3. Click (+) → Add testers
4. Enter email addresses
5. Save

Or configure di `codemagic.yaml`:
```yaml
publishing:
  app_store_connect:
    submit_to_testflight: true
    beta_groups:
      - Internal Testers
      - QA Team
```

---

## 🔄 Git & GitHub Issues

### ❌ "Codemagic not detecting push"

**Problem:** Push ke GitHub tapi build tidak trigger.

**Solution:**

1. **Check Webhook:**
   - GitHub repo → Settings → Webhooks
   - Should see Codemagic webhook
   - Recent deliveries = 200 OK

2. **Manual Trigger:**
   - Codemagic UI → Start new build

3. **Check Branch:**
   ```yaml
   # codemagic.yaml - only trigger on main
   triggering:
     events:
       - push
     branch_patterns:
       - pattern: 'main'
   ```

---

### ❌ "Git submodules not loaded"

**Solution:**

Add to `codemagic.yaml`:
```yaml
scripts:
  - name: Get submodules
    script: |
      git submodule update --init --recursive
```

---

## 📊 Performance Issues

### 🐢 "Build too slow (>15 minutes)"

**Optimization Tips:**

1. **Cache dependencies:**
   ```yaml
   cache:
     cache_paths:
       - $HOME/.pub-cache
       - $HOME/Library/Caches/CocoaPods
   ```

2. **Skip unnecessary steps:**
   ```yaml
   scripts:
     - name: Skip tests for hot builds
       script: |
         if [ "$CM_BUILD_REASON" = "push" ]; then
           echo "Skipping tests"
         fi
   ```

3. **Use smaller instance:**
   ```yaml
   instance_type: mac_mini_m1  # Faster than mac_pro
   ```

---

## 🧪 Local Testing

### "Want to test before Codemagic?"

**Android Test:**
```bash
flutter clean
flutter pub get
flutter run -d android
```

**Web Test:**
```bash
flutter run -d chrome
```

**iOS Syntax Check:**
```bash
flutter build ios --debug --no-codesign
# Will fail at signing but validates code
```

---

## 💰 Billing Issues

### ❌ "Build minutes exceeded"

**Free tier:** 500 minutes/month

**Solutions:**
1. **Optimize builds** (see performance tips)
2. **Upgrade plan**: $99/month for 3000 minutes
3. **Use debug workflow** for quick tests (faster)

---

## 📞 Getting Help

### Debug Checklist:

1. ✅ Read full error message di Codemagic logs
2. ✅ Search error di https://docs.codemagic.io
3. ✅ Check Flutter doctor: `flutter doctor -v`
4. ✅ Test locally first (Android/Web)
5. ✅ Check Codemagic status: https://status.codemagic.io

### Support Channels:

- 💬 **Codemagic Support**: https://codemagic.io/support
- 📖 **Codemagic Docs**: https://docs.codemagic.io
- 🐛 **Flutter Issues**: https://github.com/flutter/flutter/issues
- 🍎 **Apple Developer**: https://developer.apple.com/support

### Provide When Asking Help:

```
1. Build log URL dari Codemagic
2. codemagic.yaml content
3. Error message exact text
4. Flutter version: flutter --version
5. Steps already tried
```

---

## 🎓 Learning Resources

- [Codemagic Flutter Guide](https://docs.codemagic.io/flutter-configuration/flutter-projects/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
- [Apple Code Signing Guide](https://developer.apple.com/support/code-signing/)
- [TestFlight Documentation](https://developer.apple.com/testflight/)

---

## ✅ Prevention Tips

**Before Every Build:**

1. ✓ Test locally first (Android/Web)
2. ✓ Run `flutter analyze` (no errors)
3. ✓ Run `flutter test` (all pass)
4. ✓ Check `codemagic.yaml` syntax
5. ✓ Commit messages clear

**Regular Maintenance:**

1. Update Flutter: `flutter upgrade`
2. Update dependencies: `flutter pub upgrade`
3. Update pods: `pod update` (if Mac)
4. Check Xcode version compatibility

---

**Still stuck?** Check [Full Setup Guide](IOS_BUILD_SETUP.md) atau contact support! 🆘
