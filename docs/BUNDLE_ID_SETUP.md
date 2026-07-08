# Bundle ID Configuration

Bundle ID adalah unique identifier untuk iOS app. Format: `com.company.appname`

## 🎯 Current Bundle ID

```
com.kominfo.portallayananpublik
```

## 📝 Cara Mengubah Bundle ID

### Method 1: Via iOS Project (Recommended)

Jika Anda punya akses Mac:

1. Buka `ios/Runner.xcodeproj` di Xcode
2. Pilih Runner target
3. Tab "Signing & Capabilities"
4. Ubah "Bundle Identifier"

### Method 2: Edit File Langsung

Edit file: `ios/Runner.xcodeproj/project.pbxproj`

Cari dan replace semua:
```
PRODUCT_BUNDLE_IDENTIFIER = com.kominfo.portallayananpublik;
```

Dengan:
```
PRODUCT_BUNDLE_IDENTIFIER = com.yourcompany.yourappname;
```

### Method 3: Via Codemagic Config

Edit `codemagic.yaml`:

```yaml
environment:
  vars:
    BUNDLE_ID: "com.yourcompany.yourappname"
  ios_signing:
    bundle_identifier: com.yourcompany.yourappname
```

## 🔍 Verifikasi Bundle ID

```bash
# Check current bundle ID
cat ios/Runner/Info.plist | grep -A 1 "CFBundleIdentifier"
```

Atau cek di:
```xml
<!-- ios/Runner/Info.plist -->
<key>CFBundleIdentifier</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
```

## 📱 Register Bundle ID di Apple Developer

1. Login ke https://developer.apple.com
2. Certificates, Identifiers & Profiles
3. Identifiers → (+) Button
4. Pilih "App IDs" → Continue
5. Pilih "App" → Continue
6. Masukkan:
   - **Description**: Portal Layanan Publik Mobile
   - **Bundle ID**: Explicit - `com.kominfo.portallayananpublik`
7. Pilih capabilities yang diperlukan
8. Continue → Register

## ⚠️ Bundle ID Rules

1. **Unique**: Tidak boleh ada duplicate di seluruh App Store
2. **Format**: Reverse domain notation (com.company.app)
3. **Characters**: Lowercase, numbers, hyphens, dots only
4. **Cannot change** after app published ke App Store

## 🔐 Bundle ID vs App ID

- **Bundle ID**: Identifier di code (Xcode project)
- **App ID**: Registration di Apple Developer Portal
- **Harus match** untuk code signing work

## 💡 Naming Convention

```
com.[organization].[product].[platform]

Examples:
- com.kominfo.portallayanan          # Single app
- com.kominfo.portallayanan.mobile   # Mobile version
- com.kominfo.portallayanan.staging  # Staging environment
- com.kominfo.portallayanan.dev      # Development
```

## 🚀 Testing Bundle ID Changes

Setelah ubah Bundle ID:

1. Clean build:
   ```bash
   flutter clean
   cd ios
   rm -rf Pods Podfile.lock
   pod install
   cd ..
   ```

2. Build ulang:
   ```bash
   flutter build ios --release
   ```

3. Check Codemagic build logs

## 🆘 Common Issues

### ❌ "No profiles for 'com.xxx' were found"

**Solusi**: Register Bundle ID di Apple Developer Portal dulu

### ❌ "Bundle ID Already Exists"

**Solusi**: 
- Gunakan Bundle ID lain, atau
- Pemilik Bundle ID harus transfer ke account Anda

### ❌ Build Succeed tapi App Crash

**Check**:
- Bundle ID match di semua tempat
- Provisioning profile menggunakan Bundle ID yang benar

---

**Need Help?** Check [iOS Build Setup Guide](IOS_BUILD_SETUP.md)
