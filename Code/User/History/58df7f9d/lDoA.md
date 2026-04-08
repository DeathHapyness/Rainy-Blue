<div align="center">

```
██████╗  █████╗ ██╗███╗   ██╗██╗   ██╗    ██████╗ ██╗     ██╗   ██╗███████╗
██╔══██╗██╔══██╗██║████╗  ██║╚██╗ ██╔╝    ██╔══██╗██║     ██║   ██║██╔════╝
██████╔╝███████║██║██╔██╗ ██║ ╚████╔╝     ██████╔╝██║     ██║   ██║█████╗  
██╔══██╗██╔══██║██║██║╚██╗██║  ╚██╔╝      ██╔══██╗██║     ██║   ██║██╔══╝  
██║  ██║██║  ██║██║██║ ╚████║   ██║       ██████╔╝███████╗╚██████╔╝███████╗
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝   ╚═╝       ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝
```

**Linux Mint 22.3 · i3wm · Rainy Blue**

<p align="center">
  <img src="screenshots/Captura de tela de 2026-04-07 16-35-57.png" width="400">
</p>

</div>

---

## 🖥️ System Info

| | |
|---|---|
| **OS** | Linux Mint 22.3 Zena |
| **Kernel** | 6.14.0-37-generic |
| **WM** | i3 |
| **Shell** | zsh |
| **Terminal** | Kitty |
| **CPU** | AMD Ryzen 5 3600 |
| **GPU** | AMD Radeon RX 6600 XT |
| **RAM** | 31.27 GiB |
| **Resolution** | 2560x1080 + 1920x1080 |

---

## 🎨 Components

| Component | Tool |
|---|---|
| **Bar** | Polybar |
| **Compositor** | Picom |
| **Launcher** | Rofi |
| **Notifications** | Dunst |
| **Wallpaper** | feh |
| **File Manager** | Thunar |
| **Browser** | Firefox |
| **Editor** | VSCode |
| **Music** | Spotify |
| **Font** | JetBrainsMono Nerd Font |
| **GTK Theme** | Nordic |
| **Icon Theme** | Nordzy |

---

## 🎨 Color Palette (Rainy Blue)

```
Background  #1a1c23   ████
Foreground  #d8dee9   ████
Blue        #5e81ac   ████
Cyan        #88c0d0   ████
Slate       #4c566a   ████
Urgent      #bf616a   ████
```

---

## ⌨️ Keybindings

### Essenciais

| Tecla | Ação |
|---|---|
| `Super + Enter` | Abre o terminal (Kitty) |
| `Super + Q` | Fecha a janela |
| `Super + Space` | Abre o Rofi (launcher) |
| `Super + B` | Abre o Firefox |
| `Super + C` | Abre o VSCode |
| `Super + Shift + E` | Abre o Thunar |
| `Super + S` | Abre o Spotify |

### Workspaces

| Tecla | Ação |
|---|---|
| `Super + 1~5` | Vai para workspace 1-5 |
| `Super + Shift + 1~5` | Move janela para workspace 1-5 |

### Navegação

| Tecla | Ação |
|---|---|
| `Super + ← ↑ ↓ →` | Muda foco entre janelas |
| `Super + Shift + ← ↑ ↓ →` | Move janela |
| `Super + F` | Fullscreen toggle |
| `Super + W` | Layout tabbed |
| `Super + E` | Layout split toggle |
| `Super + H` | Split horizontal |
| `Super + V` | Split vertical |

### Sistema

| Tecla | Ação |
|---|---|
| `Super + Shift + C` | Reload config do i3 |
| `Super + Shift + R` | Restart i3 |
| `Super + R` | Modo resize |
| `XF86AudioRaiseVolume` | Volume + |
| `XF86AudioLowerVolume` | Volume - |
| `XF86AudioMute` | Mute toggle |

---

## 📁 Estrutura de Arquivos

```
~/.config/
├── i3/
│   └── config
├── polybar/
│   ├── config.ini
│   ├── launch.sh
│   └── scripts/
│       ├── workspaces.sh
│       └── update.sh
├── picom/
│   └── picom.conf
├── kitty/
│   └── kitty.conf
└── dunst/
    └── dunstrc
```

---

## 🚀 Instalação

### Dependências

```bash
sudo apt install i3 polybar picom rofi dunst feh kitty lxappearance git python3 btop nitrogen
```

### Flatpaks

```bash
flatpak install flathub com.spotify.Client
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.obsproject.Studio
```

### GTK Theme (Nordic)

```bash
mkdir -p ~/.themes
git clone https://github.com/EliverLara/Nordic.git ~/.themes/Nordic
```

### Icon Theme (Nordzy)

```bash
git clone https://github.com/alvatip/Nordzy-icon.git
cd Nordzy-icon && ./install.sh
```

Abra o `lxappearance` e selecione **Nordic** e **Nordzy**.

### Fontes

```bash
# Baixe JetBrainsMono Nerd Font em:
# https://www.nerdfonts.com/font-downloads
mkdir -p ~/.local/share/fonts
cp JetBrainsMono*.ttf ~/.local/share/fonts/
fc-cache -fv
```

### Polybar

```bash
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/scripts/workspaces.sh
```

### Multi-monitor (opcional)

Adicione no i3 config:

```bash
exec --no-startup-id xrandr --output HDMI-A-0 --mode 1920x1080 --right-of DisplayPort-1
```
Esse e um exemplo apenas.

---

## 🔄 Script de Atualização

```bash
bash chmod +x ~/.config/polybar/scripts/updates.sh
```

Atualiza apt + flatpaks com notificações via dunst.

---

## I3

1- Fazer logout (ou use o menu gráfico)
logout
```bash
 NA TELA DE LOGIN (LightDM):
 1. Clique no ícone de engrenagem ⚙️
 2. Selecione: i3 (ou i3wm) 

 Primeira vez no i3:
 - Escolha o teclado (ex: br-abnt2)
 - Escolha a tecla MOD (Win recomendado)

 Clonar a ricing
git clone https://github.com/DeathHapyness/Rainy-Blue.git
```
2-Copiar configs individuais
```bash
cp -r .config/i3 ~/.config/
cp -r .config/polybar ~/.config/
cp -r .config/picom ~/.config/
cp -r .config/kitty ~/.config/
cp -r .config/dunst ~/.config/
cp -r .config/rofi ~/.config/
cp -r .config/nvim ~/.config/
cp -r .config/btop ~/.config/
cp -r .config/nitrogen ~/.config/
cp -r .config/lxappearance ~/.config/
```
--- 

## 📸 Screenshots

<p align="center">
  <img src="screenshots/Captura de tela de 2026-04-07 16-34-28.png" width="400">
</p>

<p align="center">
  <img src="screenshots/Captura de tela de 2026-04-07 16-35-57.png" width="400">
</p>

<p align="center">
  <img src="screenshots/Captura de tela de 2026-04-08 01-19-12.png" width="400">
</p>

---

<div align="center">

feito com 🌧️ no Linux Mint

</div>