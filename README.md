# Ubuntu WSL + Docker Desktop Setup Guide

Automated Ubuntu WSL installation script with Docker Desktop integration instructions.

## Prerequisites

- Windows 10 version 2004+ or Windows 11
- Local Administrator

## Part 1: Automated WSL Ubuntu Installation

### Step 1: Download 'wsl-ubuntu-install.ps1' Script

### Step 2: Run Script

1. **Open PowerShell as Administrator:**
   - Right-click Start button
   - Select "Windows PowerShell (Admin)" or "Terminal (Admin)"
   - Click "Yes" on UAC prompt

2. **Navigate to script location:**
   ```powershell
   cd C:\path\to\your\script
   ```

3. **Allow script execution:**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

4. **Run the script:**
   ```powershell
   .\wsl-ubuntu-install.ps1
   ```

5. **Follow prompts:**
   - Type `y` to proceed
   - Script will restart computer automatically if needed

### Step 3: Complete Ubuntu Setup

After restart:
1. Launch Ubuntu app
2. Wait for installation (2-5 minutes)
3. Finnish installation

## Part 2: Docker Desktop Integration

### Step 1: Install Docker Desktop

1. **Download Docker Desktop:**
   - Visit: https://www.docker.com/products/docker-desktop/
   - Download for Windows

2. **Install Docker Desktop:**
   - Run installer as Administrator
   - Restart when prompted

### Step 2: Configure WSL Integration

1. **Launch Docker Desktop**

2. **Enable WSL 2 Engine:**
   - Go to **Settings** → **General**
   - Check "Use the WSL 2 based engine"
   - Click "Apply & Restart"

3. **Enable Ubuntu Integration:**
   - Go to **Settings** → **Resources** → **WSL Integration**
   - Toggle on "Enable integration with my default WSL distro"
   - Toggle on "Ubuntu" in the list
   - Click "Apply & Restart"

### Step 3: Verify Installation

Open Ubuntu terminal and test:

```bash
# Check Docker version
docker --version

# Test Docker functionality  
docker run hello-world

# Check Docker Compose
docker compose version
```

Expected output:
```
Docker version 24.x.x, build xxxxxx
Hello from Docker!
Docker Compose version v2.x.x
```

## Troubleshooting

### Docker Issues

**Docker commands not found in Ubuntu:**
- Verify WSL integration is enabled in Docker Desktop settings
- Restart Docker Desktop
- Run `wsl --shutdown` and restart Ubuntu

**Docker daemon not running:**
- Ensure Docker Desktop is running
- Check system tray for Docker icon
- Restart Docker Desktop service

**Performance issues:**
- Limit Docker Desktop memory in **Settings** → **Resources**
- Store projects in WSL filesystem (`/home/username/projects/`) not Windows drives (`/mnt/c/`)

