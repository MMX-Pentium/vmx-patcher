@echo off

set vmx=%~1

if exist "%vmx%" (
    echo vmx Path "%vmx%"
    goto userselect
) else (
    echo "%vmx%" �����݂��܂���B
    pause
    exit
)


:userselect
echo 1:�t�@�[���E�F�A��UEFI�ɐݒ�
echo 2:�t�@�[���E�F�A��BIOS�ɐݒ�
echo 3:�T�C�h�`���l���̊ɘa�𖳌���
set /p num="���s����ԍ������:"

if %num%==1 (
    set firmtype=efi
    goto firmedit
) else if %num%==2 (
    set firmtype=bios
    goto firmedit
) else if %num%==3 (
    goto sidedis
) else (
    echo 1,2,3�̂����ꂩ�����
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

echo ��������
pause
exit

:sidedis
echo ulm.disableMitigations="TRUE" >>"%vmx%"

echo ��������
pause
exit