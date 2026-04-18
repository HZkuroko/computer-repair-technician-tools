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
