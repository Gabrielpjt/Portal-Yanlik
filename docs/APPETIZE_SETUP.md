# 📱 Setup Appetize.io Demo - Complete Guide

Build iOS app untuk demo di Appetize.io dari Windows (tanpa Mac).

## 🎯 Overview

Appetize.io adalah platform untuk demo iOS/Android app di browser. Perfect untuk:
- ✅ Client presentations
- ✅ Stakeholder demos
- ✅ Documentation screenshots
- ✅ Marketing materials
- ✅ Testing tanpa device

## 🚀 Quick Start (15 Menit)

### Step 1: Build via Codemagic (5 menit)

```bash
# 1. Commit & push code
git add .
git commit -m "Add Appetize.io build workflow"
git push origin main

# 2. Buka Codemagic dashboard
# https://codemagic.io/apps

# 3. Start new build:
#    - Workflow: ios-appetize-workflow
#    - Branch: main
#    - Click "Start build"

# 4. Wait ~5-10 minutes ☕
```

### Step 2: Download .zip (1 menit)

1. Build selesai → Klik tab **"Artifacts"**
2. Download: **`appetize-demo.zip`**
3. File size ~50-100 MB

### Step 3: Upload ke Appetize.io (5 menit)

1. **Sign up**: https://appetize.io/signup
2. **Upload App**:
   - Platform: **iOS**
   - Upload file: **appetize-demo.zip**
   - Wait ~2-5 minutes (processing)
3. **Configure**:
   - Device: **iPhone 15 Pro**
   - iOS Version: **Latest**
   - Orientation: **Portrait**
4. **Save & Get Link**:
   - Public link: `https://appetize.io/app/xxxxx`
   - Copy dan share! 🎉

### Step 4: Demo! 🎬

- Open link di browser (Chrome/Safari/Firefox)
- iOS simulator muncul
- Interact seperti device asli
- Share link ke siapa saja!

---

## 📦 File Format untuk Appetize.io

Appetize.io support 3 format iOS:

| Format | Description | Best For |
|--------|-------------|----------|
| **`.zip`** | Zipped .app bundle | ✅ Recommended |
| **`.app`** | Raw app bundle | ⚠️ Harus tar/zip manual |
| **`.ipa`** | Signed app | Production only |

**Kita pakai `.zip`** (paling mudah dan compatible).

---

## 🔧 Workflow Details

### New Workflow: `ios-appetize-workflow`

Sudah ditambahkan di `codemagic.yaml`:

```yaml
ios-appetize-workflow:
  name: iOS Build for Appetize.io
  
  # Build for simulator (Appetize needs simulator build)
  flutter build ios --debug --no-codesign --simulator
  
  # Create .zip automatically
  zip -r appetize-demo.zip Runner.app
  
  # Output: build/ios/iphonesimulator/appetize-demo.zip
```

**Kenapa simulator build?**
- Appetize.io runs iOS Simulator di cloud
- Simulator build = no code signing needed
- Faster build (~5 min vs ~10 min)
- FREE (no Apple Developer Account)

---

## 💰 Appetize.io Pricing

### Free Tier (Recommended to start)
- **100 minutes/month** free
- Perfect untuk demos
- ~20 demo sessions (5 min each)
- Public app links

### Paid Plans
| Plan | Price | Minutes | Features |
|------|-------|---------|----------|
| **Free** | $0 | 100/mo | Public links |
| **Starter** | $40/mo | Unlimited | Custom branding |
| **Pro** | $100/mo | Unlimited | Team features |
| **Enterprise** | Custom | Unlimited | SLA, support |

**Pro Tip**: 100 min/month cukup untuk most use cases!

---

## 🎨 Appetize.io Features

### 1. Device Selection
```
iPhone 15 Pro (iOS 17)
iPhone 14 (iOS 16)
iPhone SE (iOS 15)
iPad Pro 12.9"
```

### 2. Orientation
```
Portrait
Landscape
Auto-rotate
```

### 3. Network Simulation
```
- Slow 3G
- Fast 3G
- 4G
- WiFi
- Offline
```

### 4. Debug Features
```
- View logs
- Network inspector
- Performance monitoring
- Screenshot capture
```

### 5. Recording
```
- Record video demo
- Download as MP4
- Share video link
```

### 6. Embed Options
```html
<!-- Embed di website -->
<iframe 
  src="https://appetize.io/embed/YOUR_APP_ID"
  width="378" 
  height="800"
></iframe>
```

---

## 📊 Build Comparison

### Option A: Appetize Workflow (Recommended)
```bash
# Codemagic workflow: ios-appetize-workflow
Build Time: ~5-10 minutes
Output: appetize-demo.zip (~80 MB)
Requirements: None (free Codemagic)
Upload to: Appetize.io directly
Demo: Browser-based, instant share
```

### Option B: Production Workflow
```bash
# Codemagic workflow: ios-workflow
Build Time: ~10-15 minutes
Output: Runner.ipa (~100 MB)
Requirements: Apple Developer ($99/year)
Upload to: Appetize.io (also works)
Demo: More features, signed app
```

### Option C: Debug Workflow
```bash
# Codemagic workflow: ios-debug-workflow
Build Time: ~5-10 minutes
Output: Runner.app (raw bundle)
Requirements: None
Upload to: Need manual zip first
Demo: Same as Option A
```

**Recommendation**: Use **Option A** (ios-appetize-workflow) - specifically made for Appetize.io!

---

## 🛠️ Troubleshooting

### ❌ "Upload failed: Invalid file format"

**Solution**: Make sure you download `appetize-demo.zip`, not `Runner.app`.

If you only have `Runner.app`:
```bash
# Can't zip on Windows easily without Mac
# Use Codemagic ios-appetize-workflow instead
```

---

### ❌ "App crashes on Appetize"

**Possible causes**:
1. **Network requests** - Check API endpoints accessible
2. **Permissions** - Camera/location won't work in simulator
3. **Native code** - Some plugins need adjustment

**Check**:
```dart
// Detect if running in simulator
import 'dart:io' show Platform;

if (Platform.environment.containsKey('SIMULATOR_DEVICE_NAME')) {
  // Running in simulator - disable camera features
}
```

---

### ❌ "Build timeout on Codemagic"

**Solution**: Build hanya ~5-10 min normal. Kalau timeout:
```bash
# Check:
1. Dependencies issue? Run flutter pub get local
2. Large assets? Optimize images
3. Pods issue? Check ios/Podfile
```

---

### ❌ "Appetize says 'Processing' too long"

**Solution**: 
- Normal processing ~2-5 minutes
- If >10 minutes, try re-upload
- Check file size <200 MB

---

## 🎯 Best Practices

### 1. Optimize App Size
```bash
# Before building
flutter clean

# Remove unused assets
# Compress images
# Use --split-debug-info for smaller builds
```

### 2. Test Before Upload
```bash
# Test di web first
flutter run -d chrome

# Or Android
flutter run -d android

# Make sure no critical bugs
```

### 3. Prepare Demo Flow
```
Before sharing Appetize link:
1. Plan demo scenario
2. Pre-load test data
3. Test all features work
4. Note any limitations (camera, etc.)
```

### 4. Update Regularly
```bash
# New features? Re-build and re-upload
git push origin main
# → Codemagic auto-builds
# → Download new appetize-demo.zip
# → Replace on Appetize.io
```

---

## 📱 Alternative Platforms

If Appetize.io tidak cocok:

### 1. BrowserStack App Live
- **URL**: https://www.browserstack.com
- Real devices (bukan simulator)
- Free trial available
- Good for serious testing

### 2. Expo Snack (Flutter Web only)
- **URL**: https://snack.expo.dev
- Instant preview
- But not native iOS

### 3. Firebase App Distribution
- **URL**: https://firebase.google.com/products/app-distribution
- Like TestFlight but multi-platform
- Free!
- Requires Firebase setup

---

## 🎬 Demo Tips

### Recording Video
1. Start Appetize session
2. Click **"Record"** button
3. Perform demo actions
4. Stop recording
5. Download MP4 (~10-50 MB)
6. Use for:
   - YouTube tutorials
   - Social media
   - Documentation
   - Presentations

### Taking Screenshots
```
Method 1: Appetize built-in
- Click screenshot icon
- Download PNG

Method 2: Browser screenshot
- Chrome: Ctrl+Shift+I → Device toolbar → Screenshot
- Or use browser extensions
```

### Sharing Best Practices
```
✅ DO:
- Share public link: appetize.io/app/xxxxx
- Explain it's a demo/simulator
- Mention any limitations
- Provide context (what to test)

❌ DON'T:
- Share without testing first
- Claim it's a real device
- Forget to update when app changes
```

---

## 📈 Monitoring Usage

### Appetize Dashboard
```
Track:
- Total sessions
- Average duration
- Popular devices
- Geographic distribution
- Minutes used (free tier limit)
```

### Tips to Save Minutes
```
1. Use iOS-appetize-workflow (fast build)
2. Test locally first (web/android)
3. Share wisely (don't spam link)
4. Set session timeout (5-10 min)
5. Disable when not actively demoing
```

---

## ✅ Complete Checklist

### Setup Phase
- [ ] Codemagic account ready
- [ ] Repository pushed to GitHub
- [ ] `codemagic.yaml` updated with ios-appetize-workflow
- [ ] Appetize.io account created

### Build Phase
- [ ] Push code to GitHub
- [ ] Trigger ios-appetize-workflow in Codemagic
- [ ] Wait for build to complete
- [ ] Download appetize-demo.zip from artifacts

### Upload Phase
- [ ] Login to Appetize.io
- [ ] Upload appetize-demo.zip
- [ ] Wait for processing (2-5 min)
- [ ] Configure device settings
- [ ] Test demo session

### Share Phase
- [ ] Copy public link
- [ ] Test link in incognito browser
- [ ] Share with stakeholders
- [ ] Monitor usage in dashboard

---

## 🎊 Success Criteria

After setup, you should have:
- ✅ Working Appetize.io demo link
- ✅ Shareable to anyone (no install needed)
- ✅ iOS simulator in browser
- ✅ Professional demo experience
- ✅ Video recording capability

---

## 🔗 Useful Links

- [Appetize.io Documentation](https://docs.appetize.io)
- [Flutter iOS Simulator Build](https://docs.flutter.dev/deployment/ios)
- [Codemagic Flutter Guide](https://docs.codemagic.io/flutter-configuration/flutter-projects/)

---

## 📞 Need Help?

- 📖 Check: `docs/TROUBLESHOOTING.md`
- 💬 Appetize Support: https://appetize.io/support
- 🐛 GitHub Issues: Report problems

---

**Ready to demo? Follow the Quick Start above! 🚀**

Total time: **~15 minutes** from push to shareable link!
