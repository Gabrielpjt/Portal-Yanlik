# 🚀 iOS Build - Quick Start (5 Menit)

Build iOS app dari Windows tanpa Mac menggunakan Codemagic.

## ⚡ Super Quick Setup

### 1️⃣ Push ke GitHub (1 menit)
```bash
git add .
git commit -m "Add iOS build config"
git push origin main
```

### 2️⃣ Setup Codemagic (2 menit)
1. Buka: **https://codemagic.io/signup**
2. **Sign up with GitHub**
3. **Add application** → Pilih repo ini
4. Done! Codemagic detect `codemagic.yaml` otomatis ✓

### 3️⃣ First Build (2 menit)
1. Klik **"Start new build"**
2. Pilih workflow: **`ios-debug-workflow`** (tanpa signing)
3. Branch: **`main`**
4. Klik **"Start build"**

⏱️ Wait ~10 menit → Download IPA! 🎉

---

## 📱 Untuk Production Build (Perlu Apple Developer)

### Requirements:
- ✅ Apple Developer Account - **$99/year**
- ✅ Bundle ID registered di Apple Developer Portal

### Setup:
1. Codemagic → **Teams** → **Integrations**
2. **Connect App Store Connect**
3. Masukkan Apple ID + App-Specific Password
4. Run workflow: **`ios-workflow`** (production)
5. Auto-upload ke TestFlight! ✓

---

## 📚 Dokumentasi Lengkap

Butuh detail lebih? Baca:

| File | Isi |
|------|-----|
| 📱 [IOS_SETUP_SUMMARY.md](docs/IOS_SETUP_SUMMARY.md) | Overview lengkap |
| 📖 [IOS_BUILD_SETUP.md](docs/IOS_BUILD_SETUP.md) | Step-by-step detail |
| 📋 [setup_codemagic.md](scripts/setup_codemagic.md) | Checklist lengkap |
| 🔧 [BUNDLE_ID_SETUP.md](docs/BUNDLE_ID_SETUP.md) | Bundle ID config |

---

## 🎯 What You Get

✅ **3 Workflows:**
- `ios-workflow` - Production + TestFlight
- `ios-debug-workflow` - Quick test tanpa signing
- `android-workflow` - Bonus Android build

✅ **Auto Triggers:**
- Push ke `main` → Auto build
- Pull Request → Auto build
- Manual trigger kapan saja

✅ **Free Tier:**
- 500 build minutes/bulan
- ~25 iOS builds gratis
- Unlimited team members

---

## ❓ FAQ

**Q: Harus punya Mac?**  
A: TIDAK! Codemagic provides Mac VM di cloud.

**Q: Harus bayar?**  
A: Codemagic gratis (500 min/bulan). Apple Developer $99/year untuk production.

**Q: Berapa lama setup?**  
A: ~5 menit basic, ~35 menit full production setup.

**Q: Bisa test di iPhone?**  
A: Ya, via TestFlight (auto-upload dari Codemagic).

**Q: Android juga bisa?**  
A: Ya! Ada `android-workflow` juga.

---

## 🆘 Need Help?

- 💬 [Codemagic Support](https://codemagic.io/support)
- 📖 Baca docs lengkap di `docs/`
- 🐛 GitHub Issues

---

**Ready? Let's Go! 🚀**

```bash
# Step 1: Push
git push origin main

# Step 2: Buka browser
start https://codemagic.io/signup

# Step 3: Click, click, build! 
```

**Enjoy building iOS from Windows! 🎉🍎**
