@echo off
chcp 65001 >nul
title Saka-cchi V3.4 - Kazenouta Installer
echo ===============================================
echo   Saka-cchi V3.4 - Kazenouta Installer
echo ===============================================

rem ============================================================
rem サカっち V3.4 「風ノ詩 - Kazenouta」 インストーラ
rem ------------------------------------------------------------
rem このスクリプトは以下の動作を行います：
rem  1. ZIPファイルの存在確認
rem  2. ../hiro_event_core に自動展開
rem  3. 展開後、Flaskサーバーを起動
rem  4. ブラウザで GUI にアクセス可能
rem ============================================================

setlocal enabledelayedexpansion
set "ZIP_FILE=hiro_event_v3.4_kazenouta_stable.zip"
set "DEST_DIR=%~dp0..\hiro_event_core"

echo [1/4] Checking ZIP file...
if not exist "!ZIP_FILE!" (
    echo [!] ZIP file not found: !ZIP_FILE!
    pause
    exit /b
)

echo [2/4] Creating destination folder: !DEST_DIR!
if not exist "!DEST_DIR!" mkdir "!DEST_DIR!"

echo [3/4] Extracting ZIP...
powershell -NoLogo -NoProfile -Command ^
    "Expand-Archive -Path '%~dp0!ZIP_FILE!' -DestinationPath '!DEST_DIR!' -Force" ^
    2>nul

if %errorlevel% neq 0 (
    echo [!] Extraction failed.
    pause
    exit /b
)

echo [4/4] Starting Flask server...
cd /d "!DEST_DIR!\hiro_event_v3.4_kazenouta_stable\server"
python server.py

echo.
echo ===============================================
echo Installation and startup completed.
echo Access: http://127.0.0.1:8000
echo ===============================================
pause
