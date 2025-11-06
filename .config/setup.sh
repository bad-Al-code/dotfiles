#!/bin/bash
################################################################################
#                    i3 Setup Script - Complete Installation
#                    Run: chmod +x ~/setup-i3.sh && ~/setup-i3.sh
################################################################################

set -e

echo "=================================="
echo "i3 Complete Setup Script"
echo "=================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  echo -e "${RED}Please do not run as root${NC}"
  exit 1
fi

echo -e "${YELLOW}[1/8] Updating system packages...${NC}"
sudo apt update && sudo apt upgrade -y

echo ""
echo -e "${YELLOW}[2/8] Installing essential packages...${NC}"
sudo apt install -y \
  i3 \
  i3status \
  i3lock \
  dunst \
  rofi \
  nitrogen \
  lxappearance \
  arandr \
  xautolock \
  xss-lock \
  maim \
  xclip \
  xdotool \
  brightnessctl \
  playerctl \
  pavucontrol \
  network-manager-gnome \
  gnome-terminal \
  nautilus \
  fonts-font-awesome \
  papirus-icon-theme \
  gpick \
  flameshot \
  redshift-gtk \
  clipster \
  polkit-gnome \
  numlockx

echo ""
echo -e "${YELLOW}[3/8] Installing/Building Picom from source...${NC}"

# Remove old picom if exists
sudo apt remove -y picom 2>/dev/null || true

# Install build dependencies
sudo apt install -y \
  meson \
  ninja-build \
  libxext-dev \
  libxcb1-dev \
  libxcb-damage0-dev \
  libxcb-xfixes0-dev \
  libxcb-shape0-dev \
  libxcb-render-util0-dev \
  libxcb-render0-dev \
  libxcb-randr0-dev \
  libxcb-composite0-dev \
  libxcb-image0-dev \
  libxcb-present-dev \
  libxcb-xinerama0-dev \
  libpixman-1-dev \
  libdbus-1-dev \
  libconfig-dev \
  libgl1-mesa-dev \
  libpcre2-dev \
  libevdev-dev \
  uthash-dev \
  libev-dev \
  libx11-xcb-dev \
  libxcb-glx0-dev

# Clone and build picom
cd /tmp
rm -rf picom
git clone https://github.com/yshui/picom.git
cd picom
git checkout v11.2 # Latest stable version
meson setup --buildtype=release build
ninja -C build
sudo ninja -C build install

echo ""
echo -e "${YELLOW}[4/8] Creating directory structure...${NC}"
mkdir -p ~/.config/{i3,i3status,picom,rofi,dunst,gtk-3.0,gtk-4.0}
mkdir -p ~/Pictures/Screenshots

echo ""
echo -e "${YELLOW}[5/8] Backing up existing configs...${NC}"
backup_dir=~/.config/i3-backup-$(date +%Y%m%d-%H%M%S)
mkdir -p "$backup_dir"

for dir in i3 i3status picom rofi dunst gtk-3.0 gtk-4.0; do
  if [ -d ~/.config/$dir ]; then
    cp -r ~/.config/$dir "$backup_dir/"
    echo "Backed up $dir to $backup_dir"
  fi
done

echo ""
echo -e "${YELLOW}[6/8] Installing SF Pro Display font...${NC}"
if [ ! -d ~/.local/share/fonts ]; then
  mkdir -p ~/.local/share/fonts
fi

# Download and install SF Pro Display
cd /tmp
if [ ! -f SF-Pro.zip ]; then
  wget -q https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg -O SF-Pro.dmg 2>/dev/null || {
    echo -e "${YELLOW}Could not download SF Pro Display. Please install manually.${NC}"
  }
fi

# Note: You might need to manually extract .dmg file on Linux
echo -e "${GREEN}If font installation failed, manually install SF Pro Display from:${NC}"
echo "https://developer.apple.com/fonts/"
fc-cache -f -v

echo ""
echo -e "${YELLOW}[7/8] Installing optional recommended packages...${NC}"
read -p "Install Brave Browser? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install -y brave-browser
fi

echo ""
read -p "Install VS Code? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt update
  sudo apt install -y code
fi

echo ""
echo -e "${YELLOW}[8/8] Final configuration...${NC}"

# Enable numlock on startup
echo "@numlockx on" >>~/.xprofile

# Set default terminal
update-alternatives --set x-terminal-emulator /usr/bin/gnome-terminal.wrapper 2>/dev/null || true

echo ""
echo -e "${GREEN}=================================="
echo "Installation Complete!"
echo "==================================${NC}"
echo ""
echo "Next steps:"
echo "1. Copy all config files to their respective locations"
echo "2. Log out and log back into i3"
echo "3. Install additional themes with lxappearance"
echo "4. Set wallpaper with nitrogen"
echo ""
echo "Config files locations:"
echo "  - i3: ~/.config/i3/config"
echo "  - i3status: ~/.config/i3status/config"
echo "  - picom: ~/.config/picom/picom.conf"
echo "  - rofi: ~/.config/rofi/launcher.rasi"
echo "  - dunst: ~/.config/dunst/dunstrc"
echo "  - GTK-3.0: ~/.config/gtk-3.0/settings.ini"
echo "  - GTK-4.0: ~/.config/gtk-4.0/settings.ini"
echo ""
echo "Backup saved to: $backup_dir"
echo ""
echo "Key shortcuts:"
echo "  - Super+Return: Terminal"
echo "  - Super+D: Application launcher (rofi)"
echo "  - Super+Q: Close window"
echo "  - Super+F: Fullscreen"
echo "  - Super+Shift+E: Power menu"
echo "  - Super+X: Lock screen"
echo "  - Super+R: Resize mode"
echo "  - Print: Screenshot"
echo ""
echo -e "${YELLOW}Press Ctrl+C to cancel reboot, or wait 10 seconds to reboot...${NC}"
sleep 10
reboot
