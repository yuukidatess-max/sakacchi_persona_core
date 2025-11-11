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

rem --- ZIPファイル確認 ---
echo [1/4] Checking ZIP file...
if not exist "!ZIP_FILE!" (
    echo [!] ZIP file not found: !ZIP_FILE!
    rem ZIPファイルが見つからない場合は終了
    pause
    exit /b
)

rem --- 展開先フォルダ作成 ---
echo [2/4] Creating destination folder: !DEST_DIR!
if not exist "!DEST_DIR!" mkdir "!DEST_DIR!"

rem --- ZIP展開処理 ---
echo [3/4] Extracting ZIP...
powershell -NoLogo -NoProfile -Command ^
    "Expand-Archive -Path '%~dp0!ZIP_FILE!' -DestinationPath '!DEST_DIR!' -Force" ^
    2>nul

if %errorlevel% neq 0 (
    echo [!] Extraction failed.
    rem 展開エラー時の処理
    pause
    exit /b
)

rem --- Flaskサーバー起動 ---
echo [4/4] Starting Flask server...
cd /d "!DEST_DIR!\hiro_event_v3.4_kazenouta_stable\server"
python server.py

echo.
echo ===============================================
echo Installation and startup completed.
echo Access: http://127.0.0.1:8000
echo ===============================================
rem --- 起動完了後に一時停止（ウィンドウを閉じないように） ---
pause
