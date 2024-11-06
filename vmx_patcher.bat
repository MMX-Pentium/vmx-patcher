@echo off

:: ファイルパスを引数として取得（スペース対応のために引用符で囲む）
set "vmx=%~1"

:: ファイルの存在チェック
if exist "%vmx%" (
    echo 指定されたファイルが見つかりました: "%vmx%"
    goto show_menu
) else (
    echo ファイルが存在しません。
    pause
    exit /b
)

:show_menu
echo 選択してください:
echo 1: ファームウェアをUEFIに設定
echo 2: ファームウェアをBIOSに設定
echo 3: サイドチャネルの緩和を無効化
set /p "choice=実行する番号を入力: "

:: 入力値に基づいて処理を分岐
if "%choice%" == "1" (
    set "firmtype=efi"
    goto configure_firmware
) else if "%choice%" == "2" (
    set "firmtype=bios"
    goto configure_firmware
) else if "%choice%" == "3" (
    goto disable_sidechannel_mitigations
) else (
    echo 無効な入力です。1, 2, または 3 を入力してください。
    goto show_menu
)

:configure_firmware
:: "firmware"設定が存在する場合、既存の"firmware"行を除外した一時ファイルを作成
findstr /v /c:"firmware = " "%vmx%" > "%vmx%.tmp"

:: 新しいファームウェア設定を一時ファイルに追加
echo firmware = "%firmtype%" >> "%vmx%.tmp"

:: 元ファイルを上書き更新
move /y "%vmx%.tmp" "%vmx%"

echo ファームウェア設定を完了しました。
pause
exit /b

:disable_sidechannel_mitigations
:: サイドチャネル緩和を無効化
echo ulm.disableMitigations="TRUE" >> "%vmx%"

echo サイドチャネル緩和を無効化しました。
pause
exit /b
