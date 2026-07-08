# 📱 Flutter Web - iOS View (Quick Reference)

## ⚡ Super Quick (30 Detik)

```bash
# 1. Run (Chrome will auto-open)
flutter run -d chrome

# 2. In Chrome:
F12                  # Open DevTools
Ctrl + Shift + M     # Toggle Device Mode
Select: iPhone 14 Pro
F5                   # Reload

# DONE! iOS view in browser! 🎉
```

## 🎯 Keyboard Shortcuts

| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| **Open DevTools** | `F12` | `Cmd+Opt+I` |
| **Device Mode** | `Ctrl+Shift+M` | `Cmd+Shift+M` |
| **Reload** | `F5` | `Cmd+R` |
| **Fullscreen** | `F11` | `Cmd+Ctrl+F` |
| **Screenshot** | DevTools → ⋮ → Capture | Same |

## 📱 Popular iPhone Sizes

```
iPhone 14 Pro    393 x 852    ⭐ Recommended
iPhone 14        390 x 844
iPhone SE        375 x 667    (Compact)
iPhone 11        414 x 896    (Large)
```

## 🎬 For Demo/Presentation

```bash
# 1. Start
flutter run -d chrome

# 2. Setup view
F12 → Ctrl+Shift+M → iPhone 14 Pro → F5

# 3. Hide DevTools (cleaner view)
F12 (toggle off)

# 4. Fullscreen
F11

# 5. Present! 🎉
```

## 📸 Take Screenshot

```
Method 1 (Best quality):
DevTools → ⋮ menu → Capture screenshot
→ Saves PNG with device frame

Method 2 (Windows):
Win + Shift + S
→ Snip iPhone area

Method 3 (Any):
Alt + PrtScn → Paste in Paint/Docs
```

## 🎥 Record Video

```
Windows Game Bar:
Win + G → Click Record
→ Records 1080p video

Or use:
- OBS Studio (free, powerful)
- Loom (Chrome extension)
- Screencastify (Chrome extension)
```

## 💡 Pro Tips

**Hot Reload Works!**
```dart
// Edit code → Save
// Browser auto-updates instantly!
// No need to restart
```

**Multiple Devices**
```bash
# Open multiple Chrome windows
# Set each to different iPhone
# See all sizes at once!
```

**Dark Mode Test**
```
DevTools → ⋮ → More tools → Rendering
→ Emulate: prefers-color-scheme: dark
```

**Slow Network Test**
```
DevTools → Network tab
→ Throttling: Slow 3G
→ Test loading behavior
```

## 🆚 Quick Comparison

| Method | Time | Cost | Quality |
|--------|------|------|---------|
| **Web + DevTools** | 30 sec | FREE | Good |
| Appetize.io | 15 min | FREE* | Excellent |
| Real iPhone | N/A | $$ | Perfect |

*100 min/month free tier

## 🚀 Right Now!

Flutter web is running! In your Chrome:

1. **F12** - Open DevTools ✅
2. **Ctrl+Shift+M** - Device mode ✅
3. **Select iPhone 14 Pro** ✅
4. **F5** - Reload ✅
5. **Done!** 🎉

---

## 📖 Full Documentation

Read: `docs/WEB_DEMO_IOS_VIEW.md` for complete guide

---

**Enjoy your iOS demo in browser!** 📱✨
