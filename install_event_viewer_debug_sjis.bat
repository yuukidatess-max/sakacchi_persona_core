@echo off
chcp 65001 >nul
title サカっち V3.4 - Kazenouta インストーラー（デバッグ版）
setlocal enabledelayedexpansion

set "LOGFILE=%~dp0install_log.txt"
echo --- 実行開始 --- > "%LOGFILE%"
echo 現在の日時: %date% %time% >> "%LOGFILE%"

echo ===============================================
echo       サカっち V3.4 - Kazenouta インストーラー（デバッグ版）
echo ===============================================
echo [ログ出力先]: %LOGFILE%

set "ZIP_FILE=hiro_event_v3.4_kazenouta_stable.zip"
set "DEST_DIR=%~dp0..\hiro_event_core"

echo [1/6] ZIPファイル確認中... >> "%LOGFILE%"
if not exist "!ZIP_FILE!" (
    echo [!] ZIPファイルが見つかりません: !ZIP_FILE! >> "%LOGFILE%"
    echo ZIPファイルが見つかりません。pauseで確認してください。
    pause
    exit /b
)

echo [2/6] 展開先確認: !DEST_DIR! >> "%LOGFILE%"
if not exist "!DEST_DIR!" mkdir "!DEST_DIR!"

echo [3/6] ZIPを展開しています... >> "%LOGFILE%"
powershell -NoLogo -NoProfile -Command ^
    "Expand-Archive -Path '%~dp0!ZIP_FILE!' -DestinationPath '!DEST_DIR!' -Force" ^
    >> "%LOGFILE%" 2>&1

if %errorlevel% neq 0 (
    echo [!] 展開中にエラー発生 (%errorlevel%) >> "%LOGFILE%"
    echo 展開中にエラーが発生しました。詳細はログを確認してください。
    pause
    exit /b
)

echo [4/6] Smart App Control ブロックを解除中... >> "%LOGFILE%"
powershell -NoLogo -NoProfile -Command ^
    "Get-ChildItem -Path '!DEST_DIR!' -Recurse | Unblock-File" ^
    >> "%LOGFILE%" 2>&1

echo [5/6] Flaskサーバーを起動しています... >> "%LOGFILE%"
cd /d "!DEST_DIR!\server" >> "%LOGFILE%" 2>&1
python server.py >> "%LOGFILE%" 2>&1

set "ERR=%errorlevel%"
echo [完了コード]: !ERR! >> "%LOGFILE%"

echo.
echo ===============================================
echo インストールと起動が完了しました。
echo ログを確認: %LOGFILE%
echo アクセス: http://127.0.0.1:8000
echo ===============================================

pause
