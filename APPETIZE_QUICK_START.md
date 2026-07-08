# 🎬 Appetize.io Quick Start

Build iOS demo untuk browser dalam 15 menit!

## ⚡ Super Quick (Copy-Paste)

```bash
# 1. Push code (30 detik)
git add .
git commit -m "Add Appetize workflow"
git push origin main

# 2. Buka Codemagic (1 menit)
# https://codemagic.io/apps
# - Start new build
# - Workflow: ios-appetize-workflow  ← PENTING!
# - Branch: main
# - Start build

# 3. Wait 5-10 minutes ☕

# 4. Download (30 detik)
# Artifacts tab → Download "appetize-demo.zip"

# 5. Upload to Appetize (5 menit)
# https://appetize.io/signup
# - Sign up (gratis 100 min/bulan)
# - Upload App → Select iOS → Upload .zip
# - Wait 2-5 minutes
# - Copy public link!

# 6. DONE! Share link 🎉
```

## 📊 What You Get

- ✅ iOS simulator di browser
- ✅ Shareable link (no install needed)
- ✅ Works on any device/OS
- ✅ Record video demos
- ✅ Professional presentation

## 💰 Cost

| Item | Price |
|------|-------|
| Codemagic build | FREE (500 min/mo) |
| Appetize.io | FREE (100 min/mo) |
| **Total** | **$0** |

## 🎯 3 Workflows Available

1. **ios-appetize-workflow** ← Use this! (5-10 min)
   - Output: `appetize-demo.zip`
   - For: Browser demos

2. **ios-workflow** (10-15 min)
   - Output: `Runner.ipa`
   - For: TestFlight/App Store

3. **android-workflow** (10 min)
   - Output: `app-release.aab`
   - For: Play Store

## 🆘 Troubleshooting

**Build failed?**
```bash
# Check logs di Codemagic
# Common fix:
flutter clean && flutter pub get
git add . && git commit -m "Fix deps" && git push
```

**Upload failed?**
```bash
# Make sure:
1. Download "appetize-demo.zip" (NOT .app or .ipa)
2. File size <200 MB
3. Platform: iOS (not Android)
```

**Demo tidak jalan?**
```bash
# Check:
1. Network requests - API endpoints accessible?
2. Test local first: flutter run -d chrome
3. Read logs di Appetize console
```

## 📖 Full Documentation

- 📱 **[APPETIZE_SETUP.md](docs/APPETIZE_SETUP.md)** - Complete guide
- 🔧 **[TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** - Common issues
- 🚀 **[IOS_QUICK_START.md](IOS_QUICK_START.md)** - iOS build basics

## 🎬 Demo Tips

**Before sharing:**
1. ✓ Test demo flow yourself
2. ✓ Check all features work
3. ✓ Note limitations (camera, etc.)
4. ✓ Prepare talking points

**When sharing:**
```
Subject: Portal Layanan Publik - iOS Demo

Hi team,

Check out our iOS app demo (no install needed):
👉 https://appetize.io/app/xxxxx

Features to try:
- Home page navigation
- Service search
- Category browsing

Note: This is a simulator - some features limited.

Feedback welcome!
```

## ⏱️ Timeline

| Step | Time |
|------|------|
| Git push | 30 sec |
| Codemagic setup | 1 min |
| Build wait | 5-10 min |
| Download | 30 sec |
| Appetize signup | 2 min |
| Upload + processing | 3-5 min |
| **Total** | **~15 min** |

## 🎊 Next Steps

After first successful demo:

1. **Share** with team/stakeholders
2. **Record video** for documentation
3. **Embed** in website/docs (optional)
4. **Update regularly** when features change

---

**Ready?** Follow commands above! 🚀

**Questions?** Read [APPETIZE_SETUP.md](docs/APPETIZE_SETUP.md)

---

Made with ❤️ for easy iOS demos from Windows


---

## 🎥 Video Demo Example

After uploading to Appetize.io, your link will look like:

```
https://appetize.io/app/abc123xyz
```

Anyone can:
- Open in browser (Chrome, Safari, Firefox, Edge)
- See iOS simulator
- Interact with app
- No download/install needed!

Perfect for:
- ✅ Client presentations
- ✅ Stakeholder reviews  
- ✅ Team demos
- ✅ Documentation
- ✅ Marketing materials

---

**Total Setup Time: 15 minutes**  
**Total Cost: $0** (using free tiers)

🎉 **Enjoy demoing iOS from Windows!**
