# サカっち V3.4 インストーラー
Write-Host "==============================================="
Write-Host "  サカっち V3.4 風の詩 - セットアップ開始"
Write-Host "==============================================="

# 基本パス設定
$BaseDir  = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ZipFile  = Join-Path $BaseDir "hiro_event_v3.4_kazenouta_stable.zip"
$DestDir  = Join-Path $BaseDir "..\hiro_event_core"

# ZIP展開
if (Test-Path $ZipFile) {
    Write-Host "[1/4] ZIPファイル確認 OK"
    Write-Host "[2/4] 展開先: $DestDir"
    Expand-Archive -Path $ZipFile -DestinationPath $DestDir -Force
    Write-Host "[3/4] 展開完了"
}
else {
    Write-Host "❌ ZIPファイルが見つかりません: $ZipFile"
    exit 1
}

# ブロック解除（Windowsのみ）
if ($IsWindows) {
    Write-Host "[4/4] ブロック解除中..."
    Get-ChildItem -Path $DestDir -Recurse | Unblock-File -ErrorAction SilentlyContinue
}

# Pythonサーバ起動
$ServerPath = Join-Path $DestDir "server.py"
if (Test-Path $ServerPath) {
    Write-Host ""
    Write-Host "-----------------------------------------------"
    Write-Host "ローカルサーバを起動します..."
    Write-Host "アクセスURL: http://127.0.0.1:8000"
    Write-Host "-----------------------------------------------"
    python $ServerPath
}
else {
    Write-Host "⚠️ server.py が見つかりません。"
}

Write-Host "==============================================="
Write-Host "  セットアップ完了！"
Write-Host "==============================================="
pause
