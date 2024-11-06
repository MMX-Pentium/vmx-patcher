@echo off

:: �t�@�C���p�X�������Ƃ��Ď擾�i�X�y�[�X�Ή��̂��߂Ɉ��p���ň͂ށj
set "vmx=%~1"

:: �t�@�C���̑��݃`�F�b�N
if exist "%vmx%" (
    echo �w�肳�ꂽ�t�@�C����������܂���: "%vmx%"
    goto show_menu
) else (
    echo �t�@�C�������݂��܂���B
    pause
    exit /b
)

:show_menu
echo �I�����Ă�������:
echo 1: �t�@�[���E�F�A��UEFI�ɐݒ�
echo 2: �t�@�[���E�F�A��BIOS�ɐݒ�
echo 3: �T�C�h�`���l���̊ɘa�𖳌���
set /p "choice=���s����ԍ������: "

:: ���͒l�Ɋ�Â��ď����𕪊�
if "%choice%" == "1" (
    set "firmtype=efi"
    goto configure_firmware
) else if "%choice%" == "2" (
    set "firmtype=bios"
    goto configure_firmware
) else if "%choice%" == "3" (
    goto disable_sidechannel_mitigations
) else (
    echo �����ȓ��͂ł��B1, 2, �܂��� 3 ����͂��Ă��������B
    goto show_menu
)

:configure_firmware
:: "firmware"�ݒ肪���݂���ꍇ�A������"firmware"�s�����O�����ꎞ�t�@�C�����쐬
findstr /v /c:"firmware = " "%vmx%" > "%vmx%.tmp"

:: �V�����t�@�[���E�F�A�ݒ���ꎞ�t�@�C���ɒǉ�
echo firmware = "%firmtype%" >> "%vmx%.tmp"

:: ���t�@�C�����㏑���X�V
move /y "%vmx%.tmp" "%vmx%"

echo �t�@�[���E�F�A�ݒ���������܂����B
pause
exit /b

:disable_sidechannel_mitigations
:: �T�C�h�`���l���ɘa�𖳌���
echo ulm.disableMitigations="TRUE" >> "%vmx%"

echo �T�C�h�`���l���ɘa�𖳌������܂����B
pause
exit /b
