chcp 65001

@echo off

title 系统检修与维护工具箱

NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    color 4F
    echo.
    echo ==============================================================
    echo  错误: 请以管理员身份运行此工具
    echo ==============================================================
    echo.
    echo  请关闭当前窗口，右键点击本文件，
    echo  然后选择“以管理员身份运行”
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
echo              系统维修工具
echo =========================================
echo.
echo ******** 基础检测 (Check up) ********
echo   1. 网络设置重置
echo   2. IP 和 PING 测试
echo   3. 电池健康度报告
echo   4. 磁盘管理 (Diskpart)
echo.
echo ******** 系统功能与激活 (Windows Feature) ********
echo   5. DISM 系统维修
echo   6. 系统功能安装
echo   7. Windows 11 家庭版 转 专业版
echo   8. 微软激活工具 (MAS)
echo.
echo ******** 新系统配置 (New OS) ********
echo   9. Windows 11 自定义优化设置
echo   10. 跳过 OOBE (断网创建本地账户)
echo   11. 系统准备工具 (Sysprep)
echo   0. 退出程序
echo.
set /p choice="请输入您的选择: "

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
echo               网络重置
echo =========================================
echo.
echo 正在执行网络重置命令，请稍候...
echo.
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo.
echo 网络重置相关命令已执行完毕。
pause
goto :main_menu

:IP_and_PING_test
cls
echo =========================================
echo            IP 和 PING 测试
echo =========================================
echo.
ipconfig /all
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=要进行快速 PING 测试吗 (Y/[N])? 
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
ping baidu.com
:END
@pause
cls
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=要进行持续 PING 测试吗 (Y/[N])? 
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
echo 正在开始持续 PING 百度 (Baidu.com)...
ping -t baidu.com
:END
endlocal
echo.
echo PING 测试完成。
pause
goto :main_menu


:Battery_Report
cls
echo =========================================
echo             电池健康度报告
echo =========================================
echo.
powercfg /batteryreport /output "C:\battery_report.html"
%SystemRoot%\explorer.exe "C:\"
echo.
echo 已经为您打开 C 盘窗口，电池健康度报告 (battery_report.html) 就在里面。
echo 您可以使用浏览器打开该文件查看详情。
echo.
pause
goto :main_menu

:Diskpart
cls
echo =========================================
echo                磁盘管理
echo =========================================
echo.
Diskpart.exe
echo.
goto :main_menu


:Windows_11_Home_to_Pro
cls
echo =========================================
echo          Windows 11 家庭版 转 专业版
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
echo 请复制下面的内容，并粘贴到 PowerShell 里执行：
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
echo          Windows 11 自定义优化设置
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
echo         跳过 OOBE (断网创建本地账户)
echo =========================================
echo.
Start ms-cxh:localonly
echo.
goto :main_menu

:Sysprep
cls
echo =========================================
echo                系统准备工具
echo =========================================
echo.
C:\Windows\System32\sysprep\sysprep.exe
@pause
echo.
goto :main_menu

:invalid_choice
cls
echo =========================================
echo               无效的选择！
echo =========================================
color 4F
echo.
echo 选错了，按任意键返回主菜单重新选择吧。
echo.
pause
goto :main_menu

:eof
cls
echo 运行结束，再见！
timeout /t 2 >nul


:DISM
cls
echo =========================================
echo.           DISM ^& WMIC 工具集
echo =========================================
echo.
echo   1. 本地 DISM 修复 (需要挂载 ISO)
echo   2. 联网 DISM 修复 (自动修复)
echo   3. WinPE 离线修复 (从 PE 环境修复系统)
echo   4. 提取系统产品密钥
echo   5. 提取电脑主板序列号
echo   0. 返回主菜单
echo.
set /p dism_choice="请选择一个操作选项: "

if "%dism_choice%"=="1" goto :DISM_Local_repair
if "%dism_choice%"=="2" goto :DISM_Online_repair
if "%dism_choice%"=="3" goto :DISM_WinPE_Offline
if "%dism_choice%"=="4" goto :Product_key_extract
if "%dism_choice%"=="5" goto :Get_serialnumber
if "%dism_choice%"=="0" goto :main_menu
goto :DISM

:DISM_Local_repair
echo.
set /p drive="请输入已挂载 ISO 的驱动器盘符（例如 D）："
echo.
if exist "%drive%:\sources\install.wim" (
    set "wimpath=%drive%:\sources\install.wim"
) else if exist "%drive%:\sources\install.esd" (
    set "wimpath=%drive%:\sources\install.esd"
) else (
    color 4F
    echo 错误：在 %drive%:\sources 中未找到 install.wim 或 install.esd。
    pause
    goto :DISM
)
echo ---------------------------------------------------------
echo 该镜像中可用的 Windows 版本：
echo ---------------------------------------------------------
DISM /Get-WimInfo /WimFile:"%wimpath%"
echo ---------------------------------------------------------
echo.
set /p index="请输入您要使用的版本索引编号（Index）："
echo.
echo 正在使用索引 %index% 修复 Windows...
echo.
DISM /Online /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":%index% /LimitAccess
if %ERRORLEVEL% EQU 0 (
    echo.
    echo DISM 修复成功完成。正在启动 SFC 扫描...
    echo.
    sfc /scannow
) else (
    echo.
    echo DISM 修复失败。请确保您输入了正确的版本索引。
)
echo.
pause
goto :DISM

:DISM_Online_repair
echo 正在开始全面系统维护与修复...
echo 1/3: 正在运行 DISM 恢复健康 (RestoreHealth)...
DISM /Online /Cleanup-Image /RestoreHealth
echo 2/3: 正在运行 SFC 系统文件扫描 (Scannow)...
sfc /scannow
echo 3/3: 正在计划磁盘检查 Chkdsk (如果 C 盘正在使用，将在下次重启时自动运行)...
chkdsk C: /f /r /x
echo.
echo 全面系统维护周期已完成。
pause
goto :DISM

:Product_key_extract
echo.
wmic path SoftwareLicensingService get OA3xOriginalProductKey
echo.
slmgr.vbs /dlv
echo.
echo 如果上方没有显示密钥，请在弹出的 PowerShell (管理员) 窗口中运行以下命令：
echo.
echo (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
echo.
powershell -Command "Start-Process powershell -Verb RunAs"
echo.
pause
goto :DISM

:DISM_WinPE_Offline
:: 1. Ask for Target Windows Drive
set /p target_drive="请输入需要修复的目标 Windows 系统盘符 (例如 C 或 D): "

:: 2. Ask for ISO Source Drive
set /p iso_drive="请输入 ISO 安装源所在的盘符 (例如 E): "

:: 3. Ask for the Index with the helpful tip
echo.
echo 提示: 在许多原版 ISO 镜像中，家庭版的索引号通常是 1，专业版通常是 6。
set /p wim_index="请输入要修复的 Windows 版本的索引号: "

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
    echo [错误] 无法在 [%iso_drive%:\sources] 目录下找到 install.wim 或 install.esd。
    echo 请检查您输入的盘符是否正确。
    pause
    color 07
    goto :DISM
)

:: 6. Execute the custom command
echo.
echo 目标系统盘: %target_drive%:\
echo 镜像源路径: %wimpath% (版本索引: %wim_index%)
echo 开始执行离线修复... 这个过程可能需要较长时间，请耐心等待。
echo.

DISM /Image:%target_drive%:\ /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":%wim_index% /LimitAccess

echo.
echo 开始执行离线 SFC 扫描...
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
echo.               系统功能安装
echo =========================================
echo.
echo  1. 安装最新的 PowerShell
echo  2. 更新已安装的 PowerShell
echo  3. 安装最新的 .NET SDK
echo  4. 联网安装 WMIC 组件
echo  5. 本地离线安装 WMIC 组件
echo  6. 安装最新的 Python
echo  0. 返回主菜单
echo.
set /p feature_choice="请选择一个安装选项: "

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
echo 正在执行命令: winget install --id Microsoft.PowerShell --source winget
winget install --id Microsoft.PowerShell --source winget
pause
goto Feature_install

:upgrade
echo.
echo 正在执行命令: winget upgrade --id Microsoft.PowerShell
winget upgrade --id Microsoft.PowerShell
pause
goto Feature_install

:dotnet
echo.
echo 正在执行命令: winget install --id Microsoft.DotNet.SDK.10 --source winget
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
set /p drive="请输入已经加载的 ISO 镜像盘符 (例如输入 D): "
echo.
echo 正在从 %drive%:\sources\sxs 安装 WMIC...
echo.

:: The /Source path typically points to the 'sxs' folder on the ISO
DISM /Online /Add-Capability /CapabilityName:WMIC~~~~ /Source:%drive%:\sources\sxs /LimitAccess

if %ERRORLEVEL% EQU 0 (
    echo.
    echo WMIC 已成功安装！
) else (
    color 4F
    echo.
    echo 错误: 安装失败。
    echo 请确保 ISO 镜像已经挂载到 [%drive%:] 并且包含 'sources\sxs' 文件夹。
)
echo.
pause
goto :Feature_install

:python_install
echo.
echo [*] 正在通过 winget 安装最新版本的 Python...
winget install --id Python.Python.3.12 -e --accept-package-agreements --accept-source-agreements
echo.
echo [*] 正在升级 pip 工具...
py -m pip install --upgrade pip
pause
goto Feature_install

:main_menu
goto main_menu
