<img width="563" height="511" alt="image" src="https://github.com/user-attachments/assets/b5ddc566-a048-4f5f-b281-12fb5506628f" />

<img width="403" height="259" alt="image" src="https://github.com/user-attachments/assets/fa85c6ed-1127-4a14-aa32-294c4ce7df15" />

<img width="378" height="274" alt="image" src="https://github.com/user-attachments/assets/e1a08f03-b605-4a37-9a1f-6b4dbddc1c23" />



# computer-repair-technician-tools
A comprehensive batch utility for Windows system maintenance and optimization that I use at work

## ⚠️ Important Notes

* **Privileges**: This script requires administrative rights to modify registry keys and repair system files
* **WMIC feature need to install first before use
* **DISM local and offline mode require a installation media or iso file
* **Design for Windows 10 & 11 use
* **Disclaimer**: Some features (e.g., registry modifications and Sysprep) alter system configurations. Ensure you have backed up critical data before proceeding.
* **Compliance**: Features related to MAS are intended for technical research and educational purposes only.

## 🛠 Usage Instructions

1.  Download the `MEMX Tools_V260417.bat` file.
2.  **Run as Administrator**: Right-click the file and select "Run as Administrator" (required for most system-level operations)
3.  Navigate through the interactive menu by entering the corresponding number for the desired task

## 🚀 Key Features

### 1. System Diagnostics (Check up)
* **Network Reset**: Automates Winsock and IP reset, and flushes DNS cache
* **Connectivity Test**: Displays full IP configuration and provides options for standard or continuous PING tests
* **Battery Report**: Generates health report for laptop batteries and open the location for you
* **Disk Management**: Quick access to the Windows Diskpart utility

### 2. Windows Maintenance & Features
* **DISM Repair**: Advanced system image repair supporting Online, Local ISO, and WinPE Offline modes and other WMIC functions
* **Edition Upgrade**: Facilitates the transition from Windows 11 Home to Professional
* **Activation Tools**: Includes Microsoft Activation Scripts (MAS) integration and original product key extraction
### 3. Deployment & Customization
* **Environment Setup**: One-click installation for PowerShell 7, .NET SDK, and Python via `winget`
* **OS Optimization**: Windows 11 visual tweaks (including restoring the classic context menu), Taskbar customization, and Search box adjustments
* **Deployment Tools**: Quick access to "Skip OOBE" (local account creation) and the System Preparation (Sysprep) tool

---
*Optimized for professional system administration and deployment.*

*******************************************************************************************************************************************************

Windows 系统维护与优化工具集 (MEMX Tools)
*** 更新了中文版 ***
一套专为 Windows 系统维护和优化设计的综合性批处理（Batch）工具，也是我日常工作中的常用工具 。

⚠️ 重要提示
* **权限要求：此脚本涉及修改注册表及修复系统文件，必须以管理员权限运行 。
* **WMIC 组件：在使用相关功能前，请确保系统已安装 WMIC 功能 。
* **DISM 修复：本地 (Local) 和离线 (Offline) 模式需要挂载安装介质或 ISO 映像文件 。
* **系统兼容性：专为 Windows 10 和 Windows 11 设计 。
* **免责声明：部分功能（如注册表修改和 Sysprep）会更改系统配置 。在执行操作前，请务必备份重要数据。
* **合规性说明：脚本中集成的 MAS 相关功能仅供技术研究与教育用途 。

🛠 使用说明
1. 下载 MEMX Tools_V260417.bat 文件。
2. 以管理员身份运行：右键点击文件，选择“以管理员身份运行”（大部分系统级操作都需要此权限） 。
3. 交互式操作：根据屏幕显示的菜单，输入对应的数字编号并回车即可执行任务 。

🚀 核心功能
1. 系统诊断 (Check up)
 ** 网络重置：自动化执行 Winsock 重置、IP 重置、释放/更新 IP 以及刷新 DNS 缓存 。
 ** 网络测试：显示完整 IP 配置，并提供标准 PING 测试或针对 Google 的持续 PING 测试选项 。
  ** 电池报告：生成笔记本电脑电池健康报告，并自动为你打开存放报告的文件夹 。
  ** 磁盘管理：快速调用 Windows Diskpart 命令行工具 。

2. Windows 维护与特色功能
  ** DISM 修复：高级系统镜像修复工具，支持在线 (Online)、本地 ISO (Local) 和 WinPE 离线模式，并包含其他 WMIC 功能 。
  ** 版本升级：支持将 Windows 11 家庭版快速切换至专业版 。
  ** 激活工具：集成 Microsoft Activation Scripts (MAS) 并支持提取主板原厂 OA3 激活密钥 。

3. 系统部署与自定义
  ** 环境部署：通过 winget 一键安装最新版 PowerShell 7、.NET SDK 10 以及 Python 。
  ** 系统优化：针对 Windows 11 的视觉调整（包括恢复经典右键菜单 ）、任务栏自定义及搜索框调整 。
  ** 部署工具：快速访问“跳过 OOBE”（创建本地账户 ）及系统准备工具 (Sysprep) 。为专业系统管理与部署优化。
