@echo off

set vmx=%~1

if exist "%vmx%" (
    echo vmx Path "%vmx%"
    goto userselect
) else (
    echo "%vmx%" が存在しません。
    pause
    exit
)


:userselect
echo 1:ファームウェアをUEFIに設定
echo 2:ファームウェアをBIOSに設定
echo 3:サイドチャネルの緩和を無効化
set /p num="実行する番号を入力:"

if %num%==1 (
    set firmtype=efi
    goto firmedit
) else if %num%==2 (
    set firmtype=bios
    goto firmedit
) else if %num%==3 (
    goto sidedis
) else (
    echo 1,2,3のいずれかを入力
    goto userselect
)

:firmedit
find "firmware" "%vmx%"
if %ERRORLEVEL% == 0 (
    findstr /v /r /c:"firmware = *" "%vmx%" > "%vmx%.tmp"
    set "editfile=%vmx%.tmp"
    set exflag=1
) else (
    set editfile=%vmx%
    set exflag=0
)
echo firmware = "%firmtype%" >>"%editfile%"

if %exflag%==1 (
    move /y "%editfile%" "%vmx%"
)

echo 多分成功
pause
exit

:sidedis
echo ulm.disableMitigations="TRUE" >>"%vmx%"

echo 多分成功
pause
exit