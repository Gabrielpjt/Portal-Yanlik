# 📱 Flutter Web - iOS Simulator View

Jalankan Flutter app di browser dengan tampilan iPhone/iOS (GRATIS & MUDAH!)

## 🚀 Quick Start (1 Menit)

```bash
# Run Flutter web
flutter run -d chrome

# Di browser:
# 1. Press F12 (DevTools)
# 2. Press Ctrl+Shift+M (Device mode)
# 3. Pilih: iPhone 14 Pro
# 4. Done! 🎉
```

## 📱 Method 1: Chrome DevTools (Recommended)

### Step-by-Step:

#### 1. Run Flutter Web
```bash
flutter run -d chrome
```

Chrome akan auto-open dengan app Anda.

#### 2. Open DevTools
**Windows/Linux:**
- Press `F12`
- Or `Ctrl + Shift + I`

**Mac:**
- Press `Cmd + Option + I`

#### 3. Toggle Device Toolbar
**Windows/Linux:**
- Press `Ctrl + Shift + M`

**Mac:**
- Press `Cmd + Shift + M`

Or click icon 📱 di toolbar DevTools

#### 4. Select iPhone Device

Di dropdown "Dimensions", pilih:
- **iPhone 14 Pro** (430 x 932) ⭐ Recommended
- iPhone 14 (390 x 844)
- iPhone 13 Pro Max (428 x 926)
- iPhone 12 Pro (390 x 844)
- iPhone SE (375 x 667) - Compact
- iPhone 11 (414 x 896)
- iPhone XR (414 x 896)

#### 5. Adjust Settings (Optional)

- **Zoom**: 100% (responsive) atau 75% (see more)
- **Orientation**: Portrait / Landscape
- **Touch simulation**: Enable
- **Device pixel ratio**: Auto (Retina)

#### 6. Reload Page
Press `F5` atau `Ctrl + R`

**DONE!** Tampilan iPhone di browser! ✅

---

## 📱 Method 2: Custom HTML Frame (Advanced)

Buat wrapper HTML dengan iPhone frame visual.

### Create `web/index_ios_demo.html`:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Portal Layanan Publik - iOS Demo</title>
  <style>
    body {
      margin: 0;
      padding: 40px;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }

    .device-frame {
      width: 375px;
      height: 812px;
      background: #000;
      border-radius: 40px;
      padding: 15px;
      box-shadow: 0 20px 60px rgba(0,0,0,0.3);
      position: relative;
    }

    .device-screen {
      width: 100%;
      height: 100%;
      background: white;
      border-radius: 35px;
      overflow: hidden;
      position: relative;
    }

    .notch {
      position: absolute;
      top: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 150px;
      height: 30px;
      background: #000;
      border-radius: 0 0 20px 20px;
      z-index: 100;
    }

    iframe {
      width: 100%;
      height: 100%;
      border: none;
      display: block;
    }

    .device-info {
      text-align: center;
      margin-top: 20px;
      color: white;
      font-size: 14px;
    }

    .controls {
      position: fixed;
      top: 20px;
      right: 20px;
      background: rgba(255,255,255,0.95);
      padding: 15px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    button {
      padding: 8px 16px;
      margin: 5px;
      border: none;
      border-radius: 5px;
      background: #667eea;
      color: white;
      cursor: pointer;
      font-size: 14px;
    }

    button:hover {
      background: #764ba2;
    }

    select {
      padding: 8px;
      margin: 5px;
      border-radius: 5px;
      border: 1px solid #ddd;
    }
  </style>
</head>
<body>
  <div class="controls">
    <label>Device:</label>
    <select id="deviceSelect" onchange="changeDevice()">
      <option value="375x812">iPhone 14 Pro</option>
      <option value="390x844">iPhone 14</option>
      <option value="375x667">iPhone SE</option>
      <option value="414x896">iPhone 11</option>
    </select>
    <br>
    <button onclick="rotate()">🔄 Rotate</button>
    <button onclick="reload()">🔃 Reload</button>
    <button onclick="fullscreen()">⛶ Fullscreen</button>
  </div>

  <div class="device-container">
    <div class="device-frame" id="deviceFrame">
      <div class="device-screen">
        <div class="notch"></div>
        <iframe id="appFrame" src="index.html"></iframe>
      </div>
    </div>
    <div class="device-info">
      <strong>Portal Layanan Publik Mobile</strong><br>
      iOS Simulator View
    </div>
  </div>

  <script>
    function changeDevice() {
      const select = document.getElementById('deviceSelect');
      const [width, height] = select.value.split('x');
      const frame = document.getElementById('deviceFrame');
      frame.style.width = width + 'px';
      frame.style.height = height + 'px';
    }

    function rotate() {
      const frame = document.getElementById('deviceFrame');
      const currentWidth = frame.style.width || '375px';
      const currentHeight = frame.style.height || '812px';
      frame.style.width = currentHeight;
      frame.style.height = currentWidth;
    }

    function reload() {
      document.getElementById('appFrame').src += '';
    }

    function fullscreen() {
      const frame = document.getElementById('deviceFrame');
      if (frame.requestFullscreen) {
        frame.requestFullscreen();
      }
    }
  </script>
</body>
</html>
```

### Run dengan wrapper:

```bash
# Build web
flutter build web

# Serve dengan wrapper
cd build/web
# Copy index_ios_demo.html ke sini
python -m http.server 8000
# Or: php -S localhost:8000

# Buka: http://localhost:8000/index_ios_demo.html
```

---

## 📱 Method 3: Deploy ke Hosting + Device Preview

### Deploy ke Netlify/Vercel (GRATIS)

#### Build Flutter Web:
```bash
flutter build web --release
```

#### Deploy ke Netlify:
1. Drag & drop folder `build/web` ke https://app.netlify.com
2. Get URL: `https://your-app.netlify.app`
3. Share link!

#### View as iPhone:
Visitors can:
- Open DevTools (F12)
- Toggle device mode (Ctrl+Shift+M)
- Select iPhone device
- Or just open on real iPhone!

---

## 🎨 Browser Extensions untuk iOS Preview

### 1. Responsive Viewer (Chrome Extension)
- **Install**: Chrome Web Store → "Responsive Viewer"
- **Features**: Multiple device views side-by-side
- **Free**: Yes
- Shows iPhone 14, 13, 12, SE, etc. simultaneously

### 2. Mobile Simulator (Chrome Extension)
- **Install**: Chrome Web Store → "Mobile Simulator"
- **Features**: Device frames with realistic UI
- **Free**: Yes

### 3. Viewport Resizer (Chrome Extension)
- **Install**: Chrome Web Store → "Viewport Resizer"
- **Features**: Quick device switching
- **Presets**: All iPhone models

---

## 🖼️ Screenshot Tools

### Capture iPhone View:

#### Method A: Chrome DevTools
```
1. DevTools open + Device mode active
2. Click ⋮ (three dots) in DevTools
3. "Capture screenshot" atau "Capture full size screenshot"
4. Saves as PNG with device frame
```

#### Method B: Windows Snipping Tool
```
Win + Shift + S
→ Drag to select iPhone view
→ Auto-copied to clipboard
```

#### Method C: Browser Extensions
- **Awesome Screenshot** - Full page capture
- **Nimbus Screenshot** - Annotate + capture
- **GoFullPage** - Full scrolling page

---

## 📊 Device Dimensions Reference

| Device | Width | Height | Pixel Ratio |
|--------|-------|--------|-------------|
| iPhone 14 Pro Max | 430 | 932 | 3x |
| iPhone 14 Pro | 393 | 852 | 3x |
| iPhone 14 | 390 | 844 | 3x |
| iPhone 13 Pro | 390 | 844 | 3x |
| iPhone 12 Pro | 390 | 844 | 3x |
| iPhone 11 | 414 | 896 | 2x |
| iPhone SE (3rd) | 375 | 667 | 2x |
| iPhone XR | 414 | 896 | 2x |

**Tip**: Use iPhone 14 Pro (393x852) for modern iPhone look!

---

## 🎯 Best Practices

### For Presentations:

1. **Zoom**: Set to 100% atau 125% (clearer)
2. **Hide DevTools**: After selecting device, press F12 to hide
3. **Fullscreen**: F11 untuk full screen demo
4. **Hide Browser UI**: Chrome → `chrome://flags` → enable "Overlay Scrollbars"

### For Screenshots:

1. **Use Capture Screenshot**: DevTools built-in (best quality)
2. **Frame**: Keep device frame visible
3. **Background**: Set nice gradient (DevTools → Rendering → Emulate CSS background)

### For Videos:

1. **Screen Record**: 
   - Windows: Win + G (Game Bar)
   - OBS Studio (free, powerful)
   - Chrome extension: "Loom" or "Screencastify"

2. **Focus on iPhone view**
3. **Record at 1080p or higher**

---

## 🔧 Advanced: Custom Device Profiles

### Add Custom iPhone in Chrome:

1. DevTools → Settings (⚙️)
2. **Devices** section
3. **Add custom device**:
   - Device name: "iPhone 15 Pro" (contoh)
   - Width: 393
   - Height: 852
   - Device pixel ratio: 3
   - User agent string: (iPhone)
   - Save

Now available in device dropdown!

---

## 💡 Pro Tips

### Tip #1: Hot Reload Works!
```bash
# Changes akan auto-reload di browser
# Edit code → Save → Browser updates otomatis!
# Super cepat untuk development
```

### Tip #2: Multiple Device Views
```bash
# Open multiple Chrome windows
# Set each to different iPhone model
# See responsive behavior across devices!
```

### Tip #3: Touch Simulation
```bash
# DevTools → Settings → Experiments
# Enable "Touch simulation"
# Click + drag untuk simulate swipe gestures
```

### Tip #4: Network Throttling
```bash
# DevTools → Network tab
# Throttling dropdown → "Slow 3G" / "Fast 3G"
# Test app di slow connection (like real iOS)
```

### Tip #5: Dark Mode Testing
```bash
# DevTools → Command Palette (Ctrl+Shift+P)
# Type: "Rendering"
# Emulate CSS prefers-color-scheme: dark
# Test dark mode instantly!
```

---

## 🆚 Comparison: Web vs Appetize.io

| Feature | Flutter Web (DevTools) | Appetize.io |
|---------|----------------------|-------------|
| **Setup Time** | 1 min | 15 min |
| **Cost** | FREE | FREE (100 min/mo) |
| **Quality** | Web rendering | Real iOS simulator |
| **Performance** | Fast | Good |
| **Native Features** | Limited | More accurate |
| **Sharing** | Deploy + DevTools | Direct link |
| **Best For** | Quick dev/testing | Client demos |

**Use Web when**: Quick iteration, development, free preview

**Use Appetize when**: Client presentations, need "real" iOS

---

## ✅ Checklist

### Quick Demo Setup:
- [ ] Run `flutter run -d chrome`
- [ ] Press F12 (DevTools)
- [ ] Press Ctrl+Shift+M (Device mode)
- [ ] Select iPhone 14 Pro
- [ ] Take screenshot / demo!

### Professional Demo:
- [ ] Build: `flutter build web --release`
- [ ] Deploy to Netlify/Vercel
- [ ] Share link
- [ ] Visitors open in DevTools device mode
- [ ] Or create custom HTML frame

---

## 🆘 Troubleshooting

### ❌ "Device toolbar tidak muncul"
**Fix**: 
- Klik icon 📱 di toolbar DevTools
- Or: Menu ⋮ → More tools → Device toolbar

### ❌ "Tampilan masih full width, bukan iPhone"
**Fix**: 
- Make sure "Responsive" mode aktif (not "Dimensions")
- Select specific device dari dropdown
- Reload page (F5)

### ❌ "UI elements keliatan besar/kecil"
**Fix**:
- Adjust zoom level (75%, 100%, 125%)
- Or set "Device pixel ratio" di DevTools

---

## 📚 Resources

- [Chrome DevTools Device Mode](https://developer.chrome.com/docs/devtools/device-mode/)
- [Flutter Web Docs](https://docs.flutter.dev/get-started/web)
- [Responsive Design Testing](https://web.dev/responsive-web-design-basics/)

---

**Ready to demo?** Run `flutter run -d chrome` sekarang! 🚀

**Total setup: 30 seconds** ⚡
**Total cost: $0** 💰
