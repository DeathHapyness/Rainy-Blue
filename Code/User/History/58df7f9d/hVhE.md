# My Linux Ricing Setup

This repository contains my personalized Linux desktop environment configuration, often referred to as "ricing." It features a customized Cinnamon desktop environment with various tools, themes, and utilities for an enhanced user experience.

## Overview

This setup is built on Linux Mint with the Cinnamon desktop environment. It includes customizations for productivity, aesthetics, and functionality.

## Key Components

### Desktop Environment
- **Cinnamon**: The main desktop environment with custom applets and extensions.

### Terminal and Shell
- **Kitty**: A fast, feature-rich terminal emulator.
- **Zsh**: Shell with custom configurations.

### System Monitoring and Utilities
- **Btop**: A resource monitor that shows usage and stats for processor, memory, disks, network and processes.
- **Fastfetch**: A tool to display system information in a neat way.

### Audio and Video
- **Pavucontrol**: PulseAudio volume control.
- **Celluloid**: A simple GTK+ frontend for mpv.
- **OBS Studio**: Screen recording and live streaming software.

### File Management
- **Nemo**: Cinnamon's default file manager.
- **Thunar**: A lightweight file manager.

### Text Editing and Development
- **VS Code**: Visual Studio Code with custom settings and extensions.

### Notifications and Launchers
- **Dunst**: A lightweight notification daemon.
- **Rofi**: A window switcher, application launcher and dmenu replacement.

### Compositing and Effects
- **Picom**: A compositor for X11, providing window transparency and effects.

### Themes and Appearance
- **GTK Themes**: Custom GTK 2.0 and 3.0 themes.
- **Nitrogen**: Wallpaper setter.
- **Polybar**: A fast and easy-to-use status bar.

### Other Tools
- **Discord**: Chat application with custom settings.
- **Evolution**: Email client.
- **I3**: Tiling window manager (possibly for alternative setups).
- **Touchegg**: Multitouch gesture recognizer.

## Installation and Usage

To apply this ricing setup:

1. **Backup your current configurations**: Before applying, back up your existing `~/.config` directory.

2. **Clone or copy the configs**: Copy the contents of this directory to your `~/.config` folder.

3. **Install required software**: Ensure all mentioned tools are installed on your system. For example, on Ubuntu/Mint:
   ```
   sudo apt update
   sudo apt install cinnamon kitty zsh btop fastfetch pavucontrol celluloid obs-studio nemo thunar code dunst rofi picom nitrogen polybar discord evolution i3 touchegg
   ```

4. **Apply themes**: Use tools like `nitrogen` to set wallpapers and GTK theme managers for themes.

5. **Restart session**: Log out and back in to apply desktop environment changes.

## Customization Notes

- **Cinnamon Spices**: Custom applets and extensions are in `cinnamon/spices/`.
- **Polybar Scripts**: Custom scripts for polybar are in `polybar/scripts/`.
- **Rofi Themes**: Multiple themes available in `rofi/themes/`.
- **VS Code Extensions**: Check `Code/` for cached extensions and settings.

## Troubleshooting

- If something doesn't work, check the respective config files for syntax errors.
- Ensure all dependencies are installed.
- For Cinnamon-specific issues, check the Cinnamon settings or reinstall spices.

## Screenshots

(Add screenshots here if available)

## License

This is a personal configuration. Feel free to use and modify as needed.

## Contributing

This is a personal setup, but suggestions are welcome!