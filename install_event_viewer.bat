@echo off
chcp 65001 >nul
title サカっち V3.4 - Kazenouta インストーラ
echo ===============================================
echo     サカっち V3.4 - Kazenouta インストーラ
echo ===============================================

setlocal enabledelayedexpansion
set "ZIP_FILE=hiro_event_v3.4_kazenouta_stable.zip"
set "DEST_DIR=%~dp0..\hiro_event_core"

echo [1/4] ZIPファイル確認中...
if not exist "!ZIP_FILE!" (
    echo [!] ZIPファイル "!ZIP_FILE!" が見つかりません。
    pause
    exit /b
)

echo [2/4] 展開先フォルダを作成中: !DEST_DIR!
if not exist "!DEST_DIR!" mkdir "!DEST_DIR!"

echo [3/4] ZIPを展開中...
powershell -NoLogo -NoProfile -Command ^
    "Expand-Archive -Path '%~dp0!ZIP_FILE!' -DestinationPath '!DEST_DIR!' -Force" ^
    2>nul

if %errorlevel% neq 0 (
    echo [!] 展開中にエラーが発生しました。
    pause
    exit /b
)

echo [4/4] Flaskサーバーを起動中...
cd /d "!DEST_DIR!\hiro_event_v3.4_kazenouta_stable\server"
python server.py

echo.
echo ===============================================
echo 展開および起動が完了しました。
echo アクセス先: http://127.0.0.1:8000
echo ===============================================
pause
