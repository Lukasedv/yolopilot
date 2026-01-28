# 🚀 YoloPilot - GitHub Copilot CLI Dev Container

A secure, ready-to-use development container for [GitHub Copilot CLI](https://github.com/github/copilot-cli). This setup provides an isolated environment with firewall rules that restrict network access to only essential services.

## ⚡ Quick Start (Pre-built Image)

```bash
docker run -it --cap-add=NET_ADMIN --cap-add=NET_RAW -v "$(pwd):/workspace" -w /workspace ghcr.io/lukasedv/yolopilot:latest
```

Then inside the container: `copilot`

## ✨ Features

- **Pre-installed GitHub Copilot CLI** - Ready to use out of the box
- **Secure by default** - Firewall restricts network to GitHub, npm, and Copilot services only
- **Developer-friendly** - Includes git, ZSH with plugins, fzf, git-delta, and more
- **VS Code integration** - Pre-configured extensions and settings
- **Session persistence** - Command history preserved between container restarts

## 📋 Prerequisites

Before you begin, make sure you have:

1. **An active GitHub Copilot subscription** - [Get one here](https://github.com/features/copilot/plans)
2. **Docker Desktop** - [Download here](https://www.docker.com/products/docker-desktop/)
3. **One of the following:**
   - VS Code with Dev Containers extension (recommended for beginners)
   - OR any terminal with Docker installed (for CLI-only usage)

---

## 🖥️ Option 1: Using VS Code (Recommended for Beginners)

### Step 1: Install Required Software

1. **Install VS Code**: Download from [code.visualstudio.com](https://code.visualstudio.com/)
2. **Install Docker Desktop**: Download from [docker.com](https://www.docker.com/products/docker-desktop/)
3. **Install the Dev Containers Extension**:
   - Open VS Code
   - Press `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (Mac)
   - Search for "Dev Containers"
   - Click **Install** on the extension by Microsoft

### Step 2: Clone and Open the Repository

1. **Clone this repository**:
   ```bash
   git clone https://github.com/Lukasedv/yolopilot.git
   cd yolopilot
   ```

2. **Open in VS Code**:
   ```bash
   code .
   ```

### Step 3: Open in Dev Container

1. VS Code will detect the `.devcontainer` folder and show a notification:
   > "Folder contains a Dev Container configuration file..."
   
   Click **"Reopen in Container"**

2. **OR** use the Command Palette:
   - Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac)
   - Type: `Dev Containers: Reopen in Container`
   - Press Enter

3. **Wait for the container to build** (first time takes 2-5 minutes)

### Step 4: Start Using GitHub Copilot CLI

Once the container is ready:

1. Open the terminal in VS Code: `` Ctrl+` `` or `Cmd+` `
2. Run:
   ```bash
   copilot
   ```
3. **First time only**: You'll be prompted to login:
   - Type `/login` and press Enter
   - Follow the on-screen instructions to authenticate with GitHub

### 🎉 You're Ready!

Start chatting with Copilot! Try asking it to:
- Explain code in your project
- Help you write a new feature
- Debug an issue
- Generate tests

---

## 💻 Option 2: Using the Command Line Only

### Step 1: Install Docker

**macOS:**
```bash
brew install --cask docker
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install docker.io docker-compose
sudo usermod -aG docker $USER
# Log out and back in for group changes to take effect
```

**Windows:**
Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### Step 2: Clone and Build

```bash
git clone https://github.com/Lukasedv/yolopilot.git && cd yolopilot
```

**Option A: Use pre-built image (recommended):**
```bash
docker run -it --cap-add=NET_ADMIN --cap-add=NET_RAW -v "$(pwd):/workspace" -w /workspace ghcr.io/lukasedv/yolopilot:latest
```

**Option B: Build locally:**
```bash
docker build -t yolopilot .devcontainer/ && docker run -it --cap-add=NET_ADMIN --cap-add=NET_RAW -v "$(pwd):/workspace" -w /workspace yolopilot
```

### Step 3: Initialize Firewall and Run Copilot

Inside the container:
```bash
# Set up the firewall (run once per container start)
sudo /usr/local/bin/init-firewall.sh

# Start Copilot CLI
copilot
```

### Step 4: Login to GitHub

On first run, type `/login` and follow the prompts to authenticate.

---

## 🔧 Alternative Installation Methods for Copilot CLI

If you prefer to install Copilot CLI directly on your machine (without containers):

**macOS/Linux with Homebrew:**
```bash
brew install copilot-cli
```

**macOS/Linux with install script:**
```bash
curl -fsSL https://gh.io/copilot-install | bash
```

**Windows with WinGet:**
```powershell
winget install GitHub.Copilot
```

**npm (all platforms):**
```bash
npm install -g @github/copilot
```

---

## 🔒 Security Features

This devcontainer implements strict firewall rules that only allow connections to:

- ✅ GitHub (api.github.com, github.com)
- ✅ GitHub Copilot services
- ✅ npm registry (for package installation)
- ✅ VS Code marketplace and updates
- ❌ All other internet access is **blocked**

This makes it safe to use `copilot --dangerously-skip-permissions` for unattended operation.

---

## 📝 Common Commands

| Command | Description |
|---------|-------------|
| `copilot` | Start the Copilot CLI |
| `/login` | Login to GitHub (in Copilot) |
| `/model` | Change AI model (in Copilot) |
| `/feedback` | Submit feedback (in Copilot) |
| `/help` | Show help (in Copilot) |
| `Ctrl+C` | Exit Copilot |

---

## 🐛 Troubleshooting

### "Browser not found" during login
The container runs headless. Copy the URL shown and paste it in your browser manually.

### Container build fails
Make sure Docker is running and you have internet connectivity.

### Copilot says "quota exceeded"
Check your Copilot subscription status at [github.com/settings/copilot](https://github.com/settings/copilot)

### Firewall blocks something you need
Edit `.devcontainer/init-firewall.sh` to add additional domains to the allowlist.

---

## 📚 Resources

- [GitHub Copilot CLI Documentation](https://docs.github.com/copilot/concepts/agents/about-copilot-cli)
- [GitHub Copilot CLI Repository](https://github.com/github/copilot-cli)
- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Copilot Plans & Pricing](https://github.com/features/copilot/plans)

---

## 📄 License

MIT License - feel free to use and modify for your own projects!
