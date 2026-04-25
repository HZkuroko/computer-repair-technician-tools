@echo off
title System Utility Menu

NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
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
    goto :exit_program
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
echo.
echo *************
echo   0. Exit
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1"  goto :network_reset
if "%choice%"=="2"  goto :ip_and_ping_test
if "%choice%"=="3"  goto :battery_report
if "%choice%"=="4"  goto :diskpart
if "%choice%"=="5"  goto :dism
if "%choice%"=="6"  goto :feature_install
if "%choice%"=="7"  goto :windows_11_home_to_pro
if "%choice%"=="8"  goto :mas
if "%choice%"=="9"  goto :windows_11_customization
if "%choice%"=="10" goto :skip_oobe
if "%choice%"=="11" goto :sysprep
if "%choice%"=="0"  goto :exit_program
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

:ip_and_ping_test
cls
echo =========================================
echo           IP and PING test
echo =========================================
echo.
ipconfig /all
echo.
set /p do_ping="Do you want to do PING test (Y/[N])? "
if /I "%do_ping%"=="Y" ping 1.1.1.1
echo.
set /p do_ping_loop="Unstoppable PING test (Y/[N])? "
if /I "%do_ping_loop%"=="Y" (
    echo Start to PING Google
    ping -t google.com
)
echo.
echo PING test completed.
pause
goto :main_menu

:battery_report
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

:diskpart
cls
echo =========================================
echo                Diskpart
echo =========================================
echo.
Diskpart.exe
echo.
goto :main_menu

:windows_11_home_to_pro
cls
echo =========================================
echo          Windows 11 Home to Pro
echo =========================================
echo.
sc config licensemanager start= auto & net start licensemanager
sc config wuauserv start= auto & net start wuauserv
slmgr /skms kms.03k.org
changepk.exe /ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T
pause
goto :main_menu

:mas
cls
echo =========================================
echo                  MAS
echo =========================================
echo.
echo Copy the following to the powershell
echo.
echo "irm https://get.activated.win ^| iex"
echo.
powershell -Command "Start-Process powershell -Verb RunAs"
pause
goto :main_menu

:windows_11_customization
cls
echo =========================================
echo         Windows 11 Customization
echo =========================================
echo.
color 0A
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f
timeout /t 1 >nul
start ms-settings:easeofaccess-visualeffects
timeout /t 1 >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent"   /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f
timeout /t 1 >nul
rundll32.exe shell32.dll,Options_RunDLL 0
timeout /t 2 >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul
timeout /t 3 >nul
start ms-settings:taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul
echo.
pause
goto :main_menu

:skip_oobe
cls
echo =========================================
echo               Skip OOBE
echo =========================================
echo.
start ms-cxh:localonly
echo.
goto :main_menu

:sysprep
cls
echo =========================================
echo                Sysprep
echo =========================================
echo.
C:\Windows\System32\sysprep\sysprep.exe
pause
goto :main_menu

:dism
cls
color 0A
echo =========================================
echo            DISM ^& WMIC
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

if "%dism_choice%"=="1" goto :dism_local_repair
if "%dism_choice%"=="2" goto :dism_online_repair
if "%dism_choice%"=="3" goto :dism_winpe_offline
if "%dism_choice%"=="4" goto :product_key_extract
if "%dism_choice%"=="5" goto :get_serialnumber
if "%dism_choice%"=="0" goto :main_menu
goto :dism

:dism_local_repair
echo.
set /p drive="Enter the Drive Letter of the mounted ISO (e.g., D): "
echo.
if exist "%drive%:\sources\install.wim" (
    set "wimpath=%drive%:\sources\install.wim"
) else if exist "%drive%:\sources\install.esd" (
    set "wimpath=%drive%:\sources\install.esd"
) else (
    color 4F
    echo ERROR: install.wim or install.esd not found on %drive%:\sources.
    pause
    color 0A
    goto :dism
)
echo ---------------------------------------------------------
echo Available Windows Versions in this Image:
echo ---------------------------------------------------------
DISM /Get-WimInfo /WimFile:"%wimpath%"
echo ---------------------------------------------------------
echo.
set /p index="Enter the Index number you wish to use: "
echo.
echo Repairing Windows using Index: %index%...
echo.
DISM /Online /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":%index% /LimitAccess
if %ERRORLEVEL% EQU 0 (
    echo.
    echo DISM repair completed successfully. Starting SFC Scan...
    echo.
    sfc /scannow
) else (
    echo.
    echo DISM repair failed. Please ensure you selected the correct Index.
)
echo.
pause
goto :dism

:dism_online_repair
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
goto :dism

:product_key_extract
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
goto :dism

:dism_winpe_offline
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
    color 0A
    goto :dism
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
goto :dism

:get_serialnumber
echo.
wmic bios get serialnumber
pause
echo.
goto :dism

:feature_install
cls
color 0A
echo =========================================
echo            Feature Install
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
set /p feature_choice="Select an option: "

if "%feature_choice%"=="1" goto :install_powershell
if "%feature_choice%"=="2" goto :upgrade_powershell
if "%feature_choice%"=="3" goto :install_dotnet
if "%feature_choice%"=="4" goto :wmic_online_install
if "%feature_choice%"=="5" goto :wmic_offline_install
if "%feature_choice%"=="6" goto :python_install
if "%feature_choice%"=="0" goto :main_menu
goto :feature_install

:install_powershell
echo.
echo Running: winget install --id Microsoft.PowerShell --source winget
winget install --id Microsoft.PowerShell --source winget
pause
goto :feature_install

:upgrade_powershell
echo.
echo Running: winget upgrade --id Microsoft.PowerShell
winget upgrade --id Microsoft.PowerShell
pause
goto :feature_install

:install_dotnet
echo.
echo Running: winget install --id Microsoft.DotNet.SDK.10 --source winget
winget install --id Microsoft.DotNet.SDK.10 --source winget
pause
goto :feature_install

:wmic_online_install
echo.
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~
pause
goto :feature_install

:wmic_offline_install
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
    pause
    color 0A
    goto :feature_install
)
echo.
pause
goto :feature_install

:python_install
echo.
echo [*] Installing the newest Python version...
winget install --id Python.Python.3.12 -e --accept-package-agreements --accept-source-agreements
echo.
echo [*] Upgrading pip...
py -m pip install --upgrade pip
pause
goto :feature_install

:invalid_choice
cls
color 4F
echo =========================================
echo           Invalid Choice!
echo =========================================
echo.
echo Please enter a valid option from the menu.
echo.
pause
color 0A
goto :main_menu

:exit_program
cls
echo Exiting System Utility. Goodbye!
timeout /t 2 >nul
endlocal
exit /b 0
