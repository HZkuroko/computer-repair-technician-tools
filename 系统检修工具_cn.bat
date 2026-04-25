chcp 65001

@echo off
title 系统实用工具菜单

NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 4F
    echo.
    echo ==============================================================
    echo  错误：需要管理员权限
    echo ==============================================================
    echo.
    echo  请关闭此窗口，右键点击该文件，然后选择：
    echo  “以管理员身份运行”
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
echo           系统维护实用工具
echo =========================================
echo.
echo ******** 检查项目 ********
echo   1. 网络重置
echo   2. IP 与 PING 测试
echo   3. 电池报告
echo   4. Diskpart 分区工具
echo.
echo ******** Windows 功能 ********
echo   5. DISM 修复
echo   6. 功能组件安装
echo   7. Windows 11 家庭版转专业版
echo   8. MAS 激活工具
echo.
echo ******** 新系统部署 ********
echo   9. Windows 11 自定义设置
echo   10. 跳过 OOBE 联网界面
echo   11. Sysprep 系统准备工具
echo.
echo *************
echo   0. 退出
echo.
set /p choice="请输入你的选择: "

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
echo           网络重置
echo =========================================
echo.
echo 正在执行网络重置命令...
echo.
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo.
echo 网络重置指令已完成。
pause
goto :main_menu

:ip_and_ping_test
cls
echo =========================================
echo           IP 与 PING 测试
echo =========================================
echo.
ipconfig /all
echo.
set /p do_ping="是否进行 PING 测试 (Y/[N])? "
if /I "%do_ping%"=="Y" ping 1.1.1.1
echo.
set /p do_ping_loop="是否进行持续 PING 测试 (Y/[N])? "
if /I "%do_ping_loop%"=="Y" (
    echo 开始 PING Google
    ping -t google.com
)
echo.
echo PING 测试完成。
pause
goto :main_menu

:battery_report
cls
echo =========================================
echo             电池报告
echo =========================================
echo.
powercfg /batteryreport /output "C:\battery_report.html"
%SystemRoot%\explorer.exe "C:\"
echo.
echo 请从弹出的文件夹中打开报告以查看结果
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
echo          Windows 11 家庭版转专业版
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
echo 请将以下内容复制并粘贴到 PowerShell 中：
echo.
echo "irm https://get.activated.win ^| iex"
echo.
powershell -Command "Start-Process powershell -Verb RunAs"
pause
goto :main_menu

:windows_11_customization
cls
echo =========================================
echo         Windows 11 自定义设置
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
echo               跳过 OOBE
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
echo            DISM 与 WMIC
echo =========================================
echo.
echo   1. 本地 DISM 修复
echo   2. 在线 DISM 修复
echo   3. WinPE 离线修复
echo   4. 提取产品密钥
echo   5. 获取序列号
echo   0. 返回主菜单
echo.
set /p dism_choice="请选择一个修复选项: "

if "%dism_choice%"=="1" goto :dism_local_repair
if "%dism_choice%"=="2" goto :dism_online_repair
if "%dism_choice%"=="3" goto :dism_winpe_offline
if "%dism_choice%"=="4" goto :product_key_extract
if "%dism_choice%"=="5" goto :get_serialnumber
if "%dism_choice%"=="0" goto :main_menu
goto :dism

:dism_local_repair
echo.
set /p drive="请输入已挂载 ISO 的驱动器盘符 (例如: D): "
echo.
if exist "%drive%:\sources\install.wim" (
    set "wimpath=%drive%:\sources\install.wim"
) else if exist "%drive%:\sources\install.esd" (
    set "wimpath=%drive%:\sources\install.esd"
) else (
    color 4F
    echo 错误：在 %drive%:\sources 中未找到 install.wim 或 install.esd。
    pause
    color 0A
    goto :dism
)
echo ---------------------------------------------------------
echo 此映像中可用的 Windows 版本：
echo ---------------------------------------------------------
DISM /Get-WimInfo /WimFile:"%wimpath%"
echo ---------------------------------------------------------
echo.
set /p index="请输入你想使用的索引 (Index) 编号: "
echo.
echo 正在使用索引 %index% 修复 Windows...
echo.
DISM /Online /Cleanup-Image /RestoreHealth /Source:wim:"%wimpath%":%index% /LimitAccess
if %ERRORLEVEL% EQU 0 (
    echo.
    echo DISM 修复已成功完成。正在开始 SFC 扫描...
    echo.
    sfc /scannow
) else (
    echo.
    echo DISM 修复失败。请确保选择了正确的索引编号。
)
echo.
pause
goto :dism

:dism_online_repair
echo 正在开始全系统维护...
echo 1/3: DISM 恢复健康状态 (RestoreHealth)...
DISM /Online /Cleanup-Image /RestoreHealth
echo 2/3: SFC 扫描系统文件...
sfc /scannow
echo 3/3: Chkdsk 磁盘检查 (如果驱动器正在使用，将在下次重启时运行)...
chkdsk C: /f /r /x
echo.
echo 全系统维护周期已完成。
pause
goto :dism

:product_key_extract
echo.
wmic path SoftwareLicensingService get OA3xOriginalProductKey
echo.
slmgr.vbs /dlv
echo.
echo 尝试在 PowerShell (管理员) 中执行此操作：
echo.
echo (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
echo.
powershell -Command "Start-Process powershell -Verb RunAs"
echo.
pause
goto :dism

:dism_winpe_offline
set /p target_drive="请输入目标 Windows 驱动器盘符 (例如: C
