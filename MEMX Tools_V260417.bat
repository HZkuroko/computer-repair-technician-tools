@echo off
title System Utility Menu

NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    color 4F
    echo.
    echo ==============================================================
    echo  ERROR: ADMINISTRATOR PRIVILEGES REQUIRED
    echo ==============================================================
    echo.
    echo  Please close this window, right-click the file, and select:
    echo  "Run as Administrator"
    echo.
    echo ==============================================================
    echo.
    pause
    goto :eof
)

:main_menu
cls
color 0A
echo =========================================
echo       System Maintenance Utility
echo =========================================
echo.
echo ******** Check up ********
echo   1. Network Reset
echo   2. IP and PING test
echo   3. Battery Report
echo   4. Diskpart
echo.
echo ******** Windows Feature ********
echo   5. DISM
echo   6. Feature Install
echo   7. Windows 11 Home to Pro
echo   8. MAS
echo.
echo ******** New OS ********
echo   9. Windows 11 Customization
echo   10. Skip OOBE
echo   11. Sysprep
echo   0. Exit
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto :network_reset
if "%choice%"=="2" goto :IP_and_PING_test
if "%choice%"=="3" goto :Battery_Report
if "%choice%"=="4" goto :Diskpart
if "%choice%"=="5" goto :DISM
if "%choice%"=="6" goto :Feature_install
if "%choice%"=="7" goto :Windows_11_Home_to_Pro
if "%choice%"=="8" goto :MAS
if "%choice%"=="9" goto :Windows_11_Customization
if "%choice%"=="10" goto :Skip_OOBE
if "%choice%"=="11" goto :Sysprep
if "%choice%"=="0" goto :eof
goto :invalid_choice

:network_reset
cls
echo =========================================
echo           Network Reset
echo =========================================
echo.
echo Performing network reset commands...
echo.
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo.
echo Network reset commands completed.
pause
goto :main_menu

:IP_and_PING_test
cls
echo =========================================
echo           IP and PING test
echo =========================================
echo.
ipconfig /all
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Do you want to do PING test (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
ping 1.1.1.1
:END
@pause
cls
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Unstop PING test (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
echo Start to PING Google
ping -t google.com
:END
endlocal
echo.
echo PING test completed.
pause
goto :main_menu


:Battery_Report
cls
echo =========================================
echo             Battery Report
echo =========================================
echo.
powercfg /batteryreport /output "C:\battery_report.html"
%SystemRoot%\explorer.exe "C:\"
echo.
echo Open the report from the popped up folder to see the result
echo.
pause
goto :main_menu

:Diskpart
cls
echo =========================================
echo                Diskpart
echo =========================================
echo.
Diskpart.exe
echo.
goto :main_menu


:Windows_11_Home_to_Pro
cls
echo =========================================
echo          Windows 11 Home to Pro
echo =========================================
echo.
sc config licensemanager start= auto & net start licensemanager
sc config wuauserv start= auto & net start wuauserv
slmgr /skms kms.03k.org
changepk.exe /ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T
@pause
echo.
goto :main_menu

:MAS
cls
echo =========================================
echo                  MAS
echo =========================================
echo 
echo Copy the following to the powershell
echo 
echo "irm https://get.activated.win | iex"
echo.
powershell -Command "Start-Process powershell -Verb RunAs"
PAUSE
echo.
goto :main_menu

:Windows_11_Customization
cls
echo =========================================
echo         Windows 11 Customization
echo =========================================
echo.
color 0A
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
timeout /t 1 >nul
echo.
start ms-settings:easeofaccess-visualeffects
timeout /t 1 >nul
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f
timeout /t 1 >nul
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f
timeout /t 1 >nul
echo.
rundll32.exe shell32.dll,Options_RunDLL 0
timeout /t 2 >nul
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul
timeout /t 3 >nul
echo.
start ms-settings:taskbar
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul
echo.
@pause
echo.
goto :main_menu

:Skip_OOBE
cls
echo =========================================
echo               Skip OOBE
echo =========================================
echo.
Start ms-cxh:localonly
echo.
goto :main_menu

:Sysprep
cls
echo =========================================
echo                Sysprep
echo =========================================
echo.
C:\Windows\System32\sysprep\sysprep.exe
@pause
echo.
goto :main_menu

:invalid_choice
cls
echo =========================================
echo           Invalid Choice!
echo =========================================
color 4F
echo.
echo Please enter a valid option from the menu.
echo.
pause
goto :main_menu

:eof
cls
echo Exiting System Utility. Goodbye!
timeout /t 2 >nul


:DISM
cls
echo =========================================
echo.           DISM ^& WMIC
echo =========================================
echo.
echo   1. Local DISM repair
echo   2. Online DISM repair
echo   3. WinPE Offline repair
echo   4. Product key extract
echo   5. Get serial number
echo   0. Back to Main Menu
echo.
set /p dism_choice="Select a repair option: "

if "%dism_choice%"=="1" goto :DISM_Local_repair
if "%dism_choice%"=="2" goto :DISM_Online_repair
if "%dism_choice%"=="3" goto :DISM_WinPE_Offline
if "%dism_choice%"=="4" goto :Product_key_extract
if "%dism_choice%"=="5" goto :Get_serialnumber
if "%dism_choice%"=="0" goto :main_menu
goto :DISM

:DISM_Local_repair
echo.
set /p drive="Enter the Drive Letter of the mounted ISO (e.g., D): "
echo.
echo Searching for Windows Image on %drive%:\sources...
echo.

:: Note: Most retail ISOs use install.wim, but some use install.esd
if exist "%drive%:\sources\install.wim" (
    set "wimpath=%drive%:\sources\install.wim"
) else if exist "%drive%:\sources\install.esd" (
    set "wimpath=%drive%:\sources\install.esd"
) else (
    color 4F
    echo ERROR: install.wim or install.esd not found on %drive%:\sources.
    echo Please check your mounted drive and try again.
    pause
    goto :DISM
)

echo Found image at %wimpath%
echo Repairing Windows using local source...
echo.

:: The /Source:wim: path points DISM to index 1 of the image file
DISM /Online /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":1 /LimitAccess

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Local repair completed successfully.
) else (
    echo.
    echo Repair failed. You may need to check the Image Index (e.g., :2, :3) 
    echo if the ISO contains multiple Windows versions (Home/Pro).
)
echo.
pause
goto :DISM

:DISM_Online_repair
echo Starting full system maintenance...
echo 1/3: DISM RestoreHealth...
DISM /Online /Cleanup-Image /RestoreHealth
echo 2/3: SFC Scannow...
sfc /scannow
echo 3/3: Chkdsk (Will run on next restart if drive is in use)...
chkdsk C: /f /r /x
echo.
echo Full maintenance cycle completed.
pause
goto :DISM

:Product_key_extract
echo.
wmic path SoftwareLicensingService get OA3xOriginalProductKey
echo.
slmgr.vbs /dlv
echo.
echo Try this in PowerShell (Admin):
echo.
echo (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
echo.
powershell -Command "Start-Process powershell -Verb RunAs"
echo.
pause
goto :DISM

:DISM_WinPE_Offline
:: 1. Ask for Target Windows Drive
set /p target_drive="Enter the Target Windows drive letter (e.g., C or D): "

:: 2. Ask for ISO Source Drive
set /p iso_drive="Enter the ISO source drive letter (e.g., E): "

:: 3. Ask for the Index with the helpful tip
echo.
echo Tip: The Index is usually 1 for Home, 6 for Pro in many retail ISOs.
set /p wim_index="Enter the Index of the Windows edition: "

:: 4. Check for install.wim or install.esd
set "wimpath="
if exist "%iso_drive%:\sources\install.wim" (
    set "wimpath=%iso_drive%:\sources\install.wim"
) else if exist "%iso_drive%:\sources\install.esd" (
    set "wimpath=%iso_drive%:\sources\install.esd"
)

:: 5. Validate Source
if not defined wimpath (
    color 4F
    echo.
    echo [ERROR] Could not find install.wim or .esd on [%iso_drive%:\sources]
    echo Please verify your drive letters.
    pause
    color 07
    goto :DISM
)

:: 6. Execute the custom command
echo.
echo Target OS: %target_drive%:\
echo Image Source: %wimpath% (Index: %wim_index%)
echo Starting offline repair... Please wait.
echo.

DISM /Image:%target_drive%:\ /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":%wim_index% /LimitAccess

echo.
echo Starting offline SFC scan...
sfc /scannow /offbootdir=%target_drive%:\ /offwindir=%target_drive%:\Windows

pause
color 0A
goto :DISM

:Get_serialnumber
echo.
wmic bios get serialnumber
@pause
echo.
goto :DISM

:main_menu
goto main_menu


:Feature_install
cls
echo =========================================
echo.           Feature Install
echo =========================================
echo.
echo  1. Install Newest PowerShell (Fresh)
echo  2. Upgrade Existing PowerShell
echo  3. Install Newest .NET (SDK)
echo  4. WMIC Online install
echo  5. WMIC Offline install
echo  6. Python install
echo  0. Back to Main Menu
echo.
set /p feature_choice="Select a repair option: "

if "%feature_choice%"=="1" goto :install
if "%feature_choice%"=="2" goto :upgrade
if "%feature_choice%"=="3" goto :dotnet
if "%feature_choice%"=="4" goto :WMIC_online_install
if "%feature_choice%"=="5" goto :WMIC_offline_install
if "%feature_choice%"=="6" goto :python_install
if "%feature_choice%"=="0" goto :main_menu
goto :DISM

:install
echo.
echo Running: winget install --id Microsoft.PowerShell --source winget
winget install --id Microsoft.PowerShell --source winget
pause
goto Feature_install

:upgrade
echo.
echo Running: winget upgrade --id Microsoft.PowerShell
winget upgrade --id Microsoft.PowerShell
pause
goto Feature_install

:dotnet
echo.
echo Running: winget install --id Microsoft.DotNet.SDK.10 --source winget
winget install --id Microsoft.DotNet.SDK.10 --source winget
pause
goto Feature_install

:WMIC_online_install
echo.
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
pause
goto Feature_install

:WMIC_offline_install
echo.
set /p drive="Enter the Drive Letter of the mounted ISO (e.g., D): "
echo.
echo Installing WMIC from %drive%:\sources\sxs...
echo.

:: The /Source path typically points to the 'sxs' folder on the ISO
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~ /Source:%drive%:\sources\sxs /LimitAccess

if %ERRORLEVEL% EQU 0 (
    echo.
    echo WMIC has been successfully installed.
) else (
    color 4F
    echo.
    echo ERROR: Installation failed. 
    echo Please ensure the ISO is mounted to [%drive%:] and contains the 'sources\sxs' folder.
)
echo.
pause
goto :Feature_install

:python_install
echo.
echo [*] Installing the newest Python version...
winget install --id Python.Python.3.12 -e --accept-package-agreements --accept-source-agreements
echo.
echo [*] Upgrading pip...
py -m pip install --upgrade pip
pause
goto Feature_install

:main_menu
goto main_menu