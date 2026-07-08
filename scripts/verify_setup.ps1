# iOS Build Setup Verification Script
# Run this to check if all files are ready for Codemagic

Write-Host "Verifying iOS Build Setup..." -ForegroundColor Cyan
Write-Host ""

$allGood = $true

# Check Flutter
Write-Host "Flutter Check:" -ForegroundColor Yellow
$flutterCheck = Get-Command flutter -ErrorAction SilentlyContinue
if ($flutterCheck) {
    Write-Host "  OK Flutter installed" -ForegroundColor Green
} else {
    Write-Host "  FAIL Flutter not found" -ForegroundColor Red
    $allGood = $false
}

Write-Host ""

# Check Required Files
Write-Host "Required Files:" -ForegroundColor Yellow

$requiredFiles = @(
    "codemagic.yaml",
    "pubspec.yaml",
    "ios/Runner/Info.plist"
)

foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  FAIL $file (MISSING)" -ForegroundColor Red
        $allGood = $false
    }
}

Write-Host ""

# Check Documentation
Write-Host "Documentation:" -ForegroundColor Yellow

$docFiles = @(
    "IOS_QUICK_START.md",
    "docs/IOS_BUILD_SETUP.md",
    "docs/TROUBLESHOOTING.md"
)

foreach ($file in $docFiles) {
    if (Test-Path $file) {
        Write-Host "  OK $file" -ForegroundColor Green
    } else {
        Write-Host "  WARN $file (missing)" -ForegroundColor Yellow
    }
}

Write-Host ""

# Check Git
Write-Host "Git Setup:" -ForegroundColor Yellow
$gitCheck = Get-Command git -ErrorAction SilentlyContinue
if ($gitCheck) {
    if (Test-Path ".git") {
        Write-Host "  OK Git repository initialized" -ForegroundColor Green
    } else {
        Write-Host "  WARN Not a git repository" -ForegroundColor Yellow
    }
} else {
    Write-Host "  FAIL Git not installed" -ForegroundColor Red
    $allGood = $false
}

Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Cyan
if ($allGood) {
    Write-Host "Setup Complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Yellow
    Write-Host "  1. Push to GitHub" -ForegroundColor White
    Write-Host "  2. Sign up at codemagic.io" -ForegroundColor White
    Write-Host "  3. Start build!" -ForegroundColor White
    Write-Host ""
    Write-Host "Read IOS_QUICK_START.md for details" -ForegroundColor Cyan
} else {
    Write-Host "Setup Incomplete" -ForegroundColor Yellow
    Write-Host "Please fix the issues above" -ForegroundColor White
}
Write-Host "========================================" -ForegroundColor Cyan
