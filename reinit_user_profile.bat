REM Zach Snyder
REM St. Mary's user profile correction script

REM disable output
@echo off

REM delete icons
REM delete 9.6 installer icon
echo y | del "%userprofile%\Desktop\Dentech 9*"
REM delete "Dentech for windows" icon
echo y | del "%userprofile%\Desktop\Dentech*.lnk"
REM delete optio
echo y | del "%userprofile%\Desktop\Optio*"


REM remap \\stmarys-server\DTWIN to Z:
REM Remove the Network Drives
net use z: /delete /y

REM Map the Network Drives
net use z: \\stmarys-server\DTWIN

REM execute dentech reinstall
set __COMPAT_LAYER=RunAsInvoker
REGEDIT.EXE  /S  "Z:\Force Dentech Reinstall.reg"
pushd "Z:\"
start /wait "" cmd /c cscript "Z:\Install_Client_Shortcut.vbs"

REM xrayvision
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%userprofile%\Desktop\XVAssistant.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "\\STMARYS-SERVER\Apteryx Imaging\XVAssistant.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

Exit