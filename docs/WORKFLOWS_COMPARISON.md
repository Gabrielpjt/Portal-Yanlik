# 📊 Codemagic Workflows - Comparison

Pilih workflow yang sesuai kebutuhan Anda.

## 🎯 Quick Decision Guide

```
Need browser demo?          → ios-appetize-workflow
Need TestFlight/App Store?  → ios-workflow  
Just testing compilation?   → ios-debug-workflow
Need Android too?           → android-workflow
```

## 📱 iOS Workflows Comparison

| Feature | ios-appetize-workflow | ios-workflow | ios-debug-workflow |
|---------|----------------------|--------------|-------------------|
| **Purpose** | Browser demo | Production | Quick test |
| **Output** | `appetize-demo.zip` | `Runner.ipa` | `Runner.app` |
| **Build Time** | 5-10 min | 10-15 min | 5-10 min |
| **Code Signing** | ❌ No | ✅ Yes | ❌ No |
| **Apple Developer** | ❌ Not needed | ✅ Required ($99/yr) | ❌ Not needed |
| **Upload To** | Appetize.io | TestFlight/App Store | N/A |
| **Cost** | FREE | $99/year | FREE |
| **Best For** | Demos, presentations | Production release | Compile check |

## 🎬 Workflow Details

### 1️⃣ ios-appetize-workflow ⭐ (NEW!)

**Purpose**: Build untuk demo di browser via Appetize.io

**Command:**
```yaml
flutter build ios --debug --no-codesign --simulator
zip -r appetize-demo.zip Runner.app
```

**Output Location:**
```
build/ios/iphonesimulator/appetize-demo.zip
```

**Use When:**
- ✅ Demo ke client/stakeholder
- ✅ Share via link (no install)
- ✅ Quick preview
- ✅ Marketing/presentation
- ✅ Documentation screenshots

**Requirements:**
- Codemagic account (free)
- GitHub repo
- Appetize.io account (free 100 min/mo)

**Pros:**
- ✅ Fastest setup
- ✅ No Apple Developer needed
- ✅ Instant sharing (browser link)
- ✅ Works on any device
- ✅ Record video demos

**Cons:**
- ⚠️ Simulator only (not real device)
- ⚠️ Some features limited (camera, etc.)
- ⚠️ 100 min/month free (Appetize limit)

---

### 2️⃣ ios-workflow

**Purpose**: Production build dengan code signing untuk TestFlight/App Store

**Command:**
```yaml
flutter build ipa --release
```

**Output Location:**
```
build/ios/ipa/Runner.ipa
```

**Use When:**
- ✅ TestFlight beta testing
- ✅ App Store submission
- ✅ Real device testing
- ✅ Production releases

**Requirements:**
- Codemagic account (free)
- GitHub repo
- Apple Developer Account ($99/year)
- Bundle ID registered
- Certificates & provisioning profiles

**Pros:**
- ✅ Real device testing
- ✅ TestFlight auto-upload
- ✅ Production-ready
- ✅ All iOS features work
- ✅ App Store ready

**Cons:**
- ⚠️ Requires Apple Developer ($99/year)
- ⚠️ Longer setup (certificates, etc.)
- ⚠️ Slower build (~10-15 min)

---

### 3️⃣ ios-debug-workflow

**Purpose**: Quick validation bahwa code compiles

**Command:**
```yaml
flutter build ios --debug --no-codesign
```

**Output Location:**
```
build/ios/iphoneos/Runner.app
```

**Use When:**
- ✅ Check compilation errors
- ✅ Quick syntax validation
- ✅ Before pushing to production
- ✅ Testing build process

**Requirements:**
- Codemagic account (free)
- GitHub repo

**Pros:**
- ✅ Fastest build
- ✅ No signing needed
- ✅ Quick feedback
- ✅ Free

**Cons:**
- ⚠️ Can't install on device
- ⚠️ Can't upload anywhere
- ⚠️ Debug mode (not optimized)

---

## 🤖 Android Workflow

### android-workflow

**Purpose**: Build Android app untuk Play Store

**Command:**
```yaml
flutter build appbundle --release
```

**Output:**
```
build/app/outputs/bundle/release/app-release.aab
```

**Use When:**
- ✅ Play Store submission
- ✅ Android testing
- ✅ Parallel with iOS builds

**Requirements:**
- Keystore for signing
- Play Store account ($25 one-time)

---

## 💰 Cost Breakdown

| Workflow | Codemagic | Apple | Appetize | Total |
|----------|-----------|-------|----------|-------|
| **ios-appetize-workflow** | Free | $0 | Free* | **$0** |
| **ios-workflow** | Free | $99/yr | N/A | **$99/yr** |
| **ios-debug-workflow** | Free | $0 | N/A | **$0** |
| **android-workflow** | Free | N/A | N/A | **$0** |

*Appetize free tier: 100 minutes/month

---

## ⏱️ Build Time Comparison

```
ios-appetize-workflow:  ████████░░ 5-10 min
ios-workflow:           ██████████ 10-15 min
ios-debug-workflow:     ████████░░ 5-10 min
android-workflow:       █████████░ 8-12 min
```

First build usually slower. Subsequent builds faster due to caching.

---

## 🎯 Use Case Matrix

### Scenario: Demo to Client
**Best**: `ios-appetize-workflow`
- Browser-based, instant share
- Professional presentation
- No device needed

### Scenario: Beta Testing
**Best**: `ios-workflow`
- TestFlight distribution
- Real device testing
- Push notifications work

### Scenario: Development Testing
**Best**: `ios-debug-workflow` OR local Android
- Quick validation
- Fast feedback loop
- Free

### Scenario: App Store Release
**Best**: `ios-workflow`
- Production-ready
- Code signed
- Optimized build

### Scenario: Multi-Platform Release
**Best**: `ios-workflow` + `android-workflow`
- Both platforms
- Same codebase
- Parallel builds

---

## 🚀 Getting Started

### For First Time Users:

**Step 1**: Start with `ios-appetize-workflow`
- Easiest setup
- See results quickly
- No Apple account needed
- Free!

**Step 2**: Upgrade to `ios-workflow` when ready
- After testing
- When preparing for release
- After getting Apple Developer account

### Recommended Order:

```
1. ios-appetize-workflow (demo)
   ↓
2. ios-debug-workflow (validation)
   ↓
3. ios-workflow (production)
   ↓
4. android-workflow (bonus)
```

---

## 📋 Workflow Selection Checklist

### Choose ios-appetize-workflow if:
- [ ] Need to demo to non-technical users
- [ ] Want browser-based sharing
- [ ] Don't have Apple Developer yet
- [ ] Need quick preview
- [ ] Budget is $0

### Choose ios-workflow if:
- [ ] Ready for production
- [ ] Have Apple Developer Account
- [ ] Need TestFlight distribution
- [ ] Want real device testing
- [ ] Preparing for App Store

### Choose ios-debug-workflow if:
- [ ] Just checking compilation
- [ ] Quick validation
- [ ] CI/CD pipeline testing
- [ ] Learning/experimenting

### Choose android-workflow if:
- [ ] Also targeting Android
- [ ] Want Play Store release
- [ ] Multi-platform strategy

---

## 🔄 Workflow Triggers

All workflows can be triggered:

### Automatic Triggers:
```yaml
- Push to main branch
- Pull request (optional)
- Git tag (for releases)
```

### Manual Triggers:
```yaml
- Codemagic UI: "Start new build"
- API call (advanced)
- Scheduled builds (cron)
```

---

## 📊 Build Artifacts

| Workflow | Artifact | Size | Upload To |
|----------|----------|------|-----------|
| ios-appetize | appetize-demo.zip | ~80 MB | Appetize.io |
| ios-workflow | Runner.ipa | ~100 MB | TestFlight, App Store |
| ios-debug | Runner.app | ~80 MB | Local only |
| android | app-release.aab | ~50 MB | Play Store |

---

## 🎓 Pro Tips

### Tip #1: Parallel Builds
```yaml
# Push once, build both:
git push origin main
# → iOS and Android build simultaneously
# → Saves time!
```

### Tip #2: Workflow Naming
```yaml
# Use descriptive branch names
feature/login   → ios-debug-workflow (quick test)
develop         → ios-appetize-workflow (demo)
main            → ios-workflow (production)
```

### Tip #3: Caching
```yaml
# Codemagic caches dependencies
# First build: ~10 min
# Subsequent: ~5 min
# Keep building to benefit from cache!
```

### Tip #4: Build Only When Needed
```yaml
# Save build minutes:
- Test locally first (flutter run)
- Push when ready
- Don't push every commit
```

---

## 🆘 Common Questions

**Q: Which workflow for first demo?**  
A: `ios-appetize-workflow` - easiest and free!

**Q: Can I use both ios-appetize and ios-workflow?**  
A: Yes! Use appetize for demos, ios-workflow for production.

**Q: How to switch workflows?**  
A: In Codemagic UI, select different workflow before starting build.

**Q: Can I customize workflows?**  
A: Yes! Edit `codemagic.yaml` in your repo.

**Q: Do I need all workflows?**  
A: No! Start with one, add others as needed.

---

## ✅ Quick Reference

```bash
# Demo in browser
→ ios-appetize-workflow
  Output: appetize-demo.zip → Appetize.io

# Production release  
→ ios-workflow
  Output: Runner.ipa → TestFlight/App Store

# Quick test
→ ios-debug-workflow
  Output: Runner.app → Verify compilation

# Android release
→ android-workflow
  Output: app-release.aab → Play Store
```

---

**Need help choosing?** Check [APPETIZE_QUICK_START.md](../APPETIZE_QUICK_START.md) for getting started!
