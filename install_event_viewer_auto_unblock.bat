@echo off
chcp 65001 >nul
title サカっち V3.4 - Kazenouta インストーラー
echo ===============================================
echo       サカっち V3.4 - Kazenouta インストーラー
echo ===============================================

rem ============================================================
rem サカっち V3.4 「風ノ詩 - Kazenouta」 インストーラー
rem 手順：
rem  1. ZIPファイルの存在確認
rem  2. ../hiro_event_core に自動展開（差分上書き対応）
rem  3. 展開後 Smart App Control ブロックを自動解除
rem  4. Flask サーバーを起動
rem ============================================================

setlocal enabledelayedexpansion
set "ZIP_FILE=hiro_event_v3.4_kazenouta_stable.zip"
set "DEST_DIR=%~dp0..\hiro_event_core"

echo [1/5] ZIPファイル確認中...
if not exist "!ZIP_FILE!" (
    echo [!] ZIPファイルが見つかりません: !ZIP_FILE!
    pause
    exit /b
)

echo [2/5] 展開先を確認中: !DEST_DIR!
if not exist "!DEST_DIR!" mkdir "!DEST_DIR!"

echo [3/5] ZIPを展開しています...
powershell -NoLogo -NoProfile -Command ^
    "Expand-Archive -Path '%~dp0!ZIP_FILE!' -DestinationPath '!DEST_DIR!' -Force" ^
    2>nul

if %errorlevel% neq 0 (
    echo [!] 展開中にエラーが発生しました。
    pause
    exit /b
)

echo [4/5] Smart App Control ブロックを解除中...
powershell -NoLogo -NoProfile -Command ^
    "Get-ChildItem -Path '!DEST_DIR!' -Recurse | Unblock-File"

echo [5/5] Flaskサーバーを起動しています...
cd /d "!DEST_DIR!\server"
python server.py

echo.
echo ===============================================
echo インストールと起動が完了しました。
echo アクセス: http://127.0.0.1:8000
echo ===============================================
pause
