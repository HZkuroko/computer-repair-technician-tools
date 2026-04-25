chcp 65001

@echo off
title 系统实用工具菜单 [cite: 1]

NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 4F
    echo.
    echo ==============================================================
    echo  错误：需要管理员权限 [cite: 1]
    echo ==============================================================
    echo.
    echo  请关闭此窗口，右键点击该文件，然后选择：
    echo  “以管理员身份运行” [cite: 1]
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
echo           系统维护实用工具 [cite: 1]
echo =========================================
echo.
echo ******** 检查项目 ******** [cite: 2]
echo   1. 网络重置
echo   2. IP 与 PING 测试
echo   3. 电池报告
echo   4. Diskpart 分区工具
echo.
echo ******** Windows 功能 ******** [cite: 3]
echo   5. DISM 修复
echo   6. 功能组件安装
echo   7. Windows 11 家庭版转专业版
echo   8. MAS 激活工具
echo.
echo ******** 新系统部署 ******** [cite: 4]
echo   9. Windows 11 自定义设置
echo   10. 跳过 OOBE 联网界面
echo   11. Sysprep 系统准备工具
echo.
echo ************* [cite: 5]
echo   0. 退出
echo.
set /p choice="请输入你的选择: " [cite: 5]

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
echo           网络重置 [cite: 6]
echo =========================================
echo.
echo 正在执行网络重置命令... [cite: 6]
echo.
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo.
echo 网络重置指令已完成。 [cite: 6]
pause [cite: 7]
goto :main_menu

:ip_and_ping_test
cls
echo =========================================
echo           IP 与 PING 测试 [cite: 8]
echo =========================================
echo.
ipconfig /all
echo.
set /p do_ping="是否进行 PING 测试 (Y/[N])? " [cite: 8]
if /I "%do_ping%"=="Y" ping 1.1.1.1
echo.
set /p do_ping_loop="是否进行持续 PING 测试 (Y/[N])? " [cite: 9]
if /I "%do_ping_loop%"=="Y" (
    echo 开始 PING Google [cite: 9]
    ping -t google.com
)
echo.
echo PING 测试完成。 [cite: 10]
pause [cite: 10]
goto :main_menu

:battery_report
cls
echo =========================================
echo             电池报告 [cite: 11]
echo =========================================
echo.
powercfg /batteryreport /output "C:\battery_report.html" [cite: 11]
%SystemRoot%\explorer.exe "C:\" [cite: 11]
echo.
echo 请从弹出的文件夹中打开报告以查看结果 [cite: 11]
echo.
pause [cite: 12]
goto :main_menu

:diskpart
cls
echo =========================================
echo                Diskpart [cite: 13]
echo =========================================
echo.
Diskpart.exe [cite: 13]
echo.
goto :main_menu

:windows_11_home_to_pro
cls
echo =========================================
echo          Windows 11 家庭版转专业版 [cite: 14]
echo =========================================
echo.
sc config licensemanager start= auto & net start licensemanager [cite: 14]
sc config wuauserv start= auto & net start wuauserv [cite: 14]
slmgr /skms kms.03k.org [cite: 14]
changepk.exe /ProductKey VK7JG-NPHTM-C97JM-9MPGT-3V66T [cite: 14]
pause
goto :main_menu

:mas
cls
echo =========================================
echo                  MAS [cite: 15]
echo =========================================
echo.
echo 请将以下内容复制并粘贴到 PowerShell 中： [cite: 15]
echo.
echo "irm https://get.activated.win ^| iex"
echo.
powershell -Command "Start-Process powershell -Verb RunAs" [cite: 16]
pause
goto :main_menu

:windows_11_customization
cls
echo =========================================
echo         Windows 11 自定义设置 [cite: 17]
echo =========================================
echo.
color 0A
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve [cite: 17]
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f [cite: 17]
timeout /t 1 >nul
start ms-settings:easeofaccess-visualeffects [cite: 17]
timeout /t 1 >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent"   /t REG_DWORD /d "0" /f [cite: 17]
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f [cite: 17]
timeout /t 1 >nul
rundll32.exe shell32.dll,Options_RunDLL 0 [cite: 17]
timeout /t 2 >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul [cite: 17]
timeout /t 3 >nul
start ms-settings:taskbar [cite: 17]
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f >nul [cite: 17]
echo.
pause [cite: 18]
goto :main_menu

:skip_oobe
cls
echo =========================================
echo               跳过 OOBE [cite: 19]
echo =========================================
echo.
start ms-cxh:localonly [cite: 19]
echo.
goto :main_menu

:sysprep
cls
echo =========================================
echo                Sysprep [cite: 20]
echo =========================================
echo.
C:\Windows\System32\sysprep\sysprep.exe [cite: 20]
pause
goto :main_menu

:dism
cls
color 0A
echo =========================================
echo            DISM 与 WMIC [cite: 21]
echo =========================================
echo.
echo   1. 本地 DISM 修复
echo   2. 在线 DISM 修复
echo   3. WinPE 离线修复
echo   4. 提取产品密钥
echo   5. 获取序列号
echo   0. 返回主菜单 [cite: 21]
echo.
set /p dism_choice="请选择一个修复选项: " [cite: 22]

if "%dism_choice%"=="1" goto :dism_local_repair
if "%dism_choice%"=="2" goto :dism_online_repair
if "%dism_choice%"=="3" goto :dism_winpe_offline
if "%dism_choice%"=="4" goto :product_key_extract
if "%dism_choice%"=="5" goto :get_serialnumber
if "%dism_choice%"=="0" goto :main_menu
goto :dism

:dism_local_repair
echo.
set /p drive="请输入已挂载 ISO 的驱动器盘符 (例如: D): " [cite: 23]
echo.
if exist "%drive%:\sources\install.wim" (
    set "wimpath=%drive%:\sources\install.wim"
) else if exist "%drive%:\sources\install.esd" (
    set "wimpath=%drive%:\sources\install.esd"
) else (
    color 4F
    echo 错误：在 %drive%:\sources 中未找到 install.wim 或 install.esd。 [cite: 24]
    pause
    color 0A
    goto :dism
)
echo ---------------------------------------------------------
echo 此映像中可用的 Windows 版本： [cite: 24]
echo ---------------------------------------------------------
DISM /Get-WimInfo /WimFile:"%wimpath%"
echo ---------------------------------------------------------
echo.
set /p index="请输入你想使用的索引 (Index) 编号: " [cite: 25]
echo.
echo 正在使用索引 %index% 修复 Windows... [cite: 25]
echo.
DISM /Online /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":%index% /LimitAccess [cite: 26]
if %ERRORLEVEL% EQU 0 (
    echo.
    echo DISM 修复已成功完成。正在开始 SFC 扫描... [cite: 26]
    echo.
    sfc /scannow
) else (
    echo.
    echo DISM 修复失败。请确保选择了正确的索引编号。 [cite: 26]
)
echo.
pause [cite: 27]
goto :dism

:dism_online_repair
echo 正在开始全系统维护... [cite: 27]
echo 1/3: DISM 恢复健康状态 (RestoreHealth)...
DISM /Online /Cleanup-Image /RestoreHealth
echo 2/3: SFC 扫描系统文件...
sfc /scannow
echo 3/3: Chkdsk 磁盘检查 (如果驱动器正在使用，将在下次重启时运行)...
chkdsk C: /f /r /x
echo.
echo 全系统维护周期已完成。 [cite: 28]
pause
goto :dism

:product_key_extract
echo.
wmic path SoftwareLicensingService get OA3xOriginalProductKey
echo.
slmgr.vbs /dlv
echo.
echo 尝试在 PowerShell (管理员) 中执行此操作： [cite: 29]
echo.
echo (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey [cite: 29]
echo.
powershell -Command "Start-Process powershell -Verb RunAs" [cite: 29]
echo.
pause [cite: 30]
goto :dism

:dism_winpe_offline
:: 1. 询问目标 Windows 驱动器盘符
set /p target_drive="请输入目标 Windows 驱动器盘符 (例如: C 或 D): " [cite: 31]

:: 2. 询问 ISO 源驱动器盘符
set /p iso_drive="请输入 ISO 源驱动器盘符 (例如: E): " [cite: 31]

:: 3. 询问索引编号并提供建议
echo.
echo 提示：在许多零售版 ISO 中，家庭版索引通常为 1，专业版为 6。 [cite: 31]
set /p wim_index="请输入 Windows 版本的索引编号: " [cite: 32]

:: 4. 检查 install.wim 或 install.esd
set "wimpath="
if exist "%iso_drive%:\sources\install.wim" (
    set "wimpath=%iso_drive%:\sources\install.wim"
) else if exist "%iso_drive%:\sources\install.esd" (
    set "wimpath=%iso_drive%:\sources\install.esd"
)

:: 5. 验证源文件
if not defined wimpath (
    color 4F
    echo.
    echo [错误] 无法在 [%iso_drive%:\sources] 找到 install.wim 或 .esd [cite: 32]
    echo 请核对您的驱动器盘符。 [cite: 32]
    pause
    color 0A
    goto :dism
)

:: 6. 执行自定义命令
echo.
echo 目标系统: %target_drive%:\ [cite: 33]
echo 映像源: %wimpath% (索引: %wim_index%) [cite: 33]
echo 正在开始离线修复... 请稍候。 [cite: 33]
echo.
DISM /Image:%target_drive%:\ /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":%wim_index% /LimitAccess [cite: 34]

echo.
echo 正在开始离线 SFC 扫描... [cite: 34]
sfc /scannow /offbootdir=%target_drive%:\ /offwindir=%target_drive%:\Windows

pause
color 0A
goto :dism

:get_serialnumber
echo.
wmic bios get serialnumber
pause
echo.
goto :dism [cite: 35]

:feature_install
cls
color 0A
echo =========================================
echo            功能组件安装 [cite: 36]
echo =========================================
echo.
echo   1. 安装最新版 PowerShell (全新安装) [cite: 36]
echo   2. 升级现有 PowerShell [cite: 36]
echo   3. 安装最新版 .NET (SDK) [cite: 36]
echo   4. WMIC 在线安装 [cite: 36]
echo   5. WMIC 离线安装 [cite: 36]
echo   6. Python 安装 [cite: 36]
echo   0. 返回主菜单 [cite: 36]
echo.
set /p feature_choice="请选择一个选项: " [cite: 37]

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
echo 正在执行: winget install --id Microsoft.PowerShell --source winget [cite: 38]
winget install --id Microsoft.PowerShell --source winget
pause
goto :feature_install

:upgrade_powershell
echo.
echo 正在执行: winget upgrade --id Microsoft.PowerShell [cite: 39]
winget upgrade --id Microsoft.PowerShell
pause
goto :feature_install

:install_dotnet
echo.
echo 正在执行: winget install --id Microsoft.DotNet.SDK.10 --source winget [cite: 40]
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
set /p drive="请输入已挂载 ISO 的驱动器盘符 (例如: D): " [cite: 41]
echo.
echo 正在从 %drive%:\sources\sxs 安装 WMIC... [cite: 41]
echo.
:: /Source 路径通常指向 ISO 上的 'sxs' 文件夹 [cite: 42]
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~ /Source:%drive%:\sources\sxs /LimitAccess [cite: 42]

if %ERRORLEVEL% EQU 0 (
    echo.
    echo WMIC 已成功安装。 [cite: 42]
) else (
    color 4F
    echo.
    echo 错误：安装失败。 [cite: 42]
    echo 请确保 ISO 已挂载至 [%drive%:] 并且包含 'sources\sxs' 文件夹。 [cite: 42]
    pause
    color 0A
    goto :feature_install
)
echo.
pause [cite: 43]
goto :feature_install

:python_install
echo.
echo [*] 正在安装最新版本的 Python... [cite: 44]
winget install --id Python.Python.3.12 -e --accept-package-agreements --accept-source-agreements
echo.
echo [*] 正在升级 pip... [cite: 44]
py -m pip install --upgrade pip
pause
goto :feature_install

:invalid_choice
cls
color 4F
echo =========================================
echo           无效选择！ [cite: 45]
echo =========================================
echo.
echo 请从菜单中输入一个有效的选项。 [cite: 45]
echo.
pause
color 0A
goto :main_menu

:exit_program
cls
echo 正在退出系统工具。再见！ [cite: 46]
timeout /t 2 >nul [cite: 46]
endlocal
exit /b 0
