#!/usr/bin/env bash

# =========================
# Cores
# =========================
RESET="\e[0m"
BOLD="\e[1m"
CYAN="\e[36m"
GREEN="\e[32m"
YELLOW="\e[33m"
MAGENTA="\e[35m"
BLUE="\e[34m"
RED="\e[31m"

# =========================
# Funções para updates
# =========================
list_apt_updates() {
    apt list --upgradable 2>/dev/null | tail -n +2
}

list_flatpak_updates() {
    flatpak remote-ls --updates 2>/dev/null
}

# =========================
# Coleta de updates
# =========================
apt_updates=$(list_apt_updates)
apt_count=$(echo "$apt_updates" | grep -c .)

flatpak_updates=$(list_flatpak_updates)
flatpak_count=$(echo "$flatpak_updates" | grep -c .)

total=$((apt_count + flatpak_count))

# =========================
# Ícone Polybar
# =========================
if [ "$total" -gt 0 ]; then
    echo "󰏗 $total"
else
    exit 0
fi

# =========================
# Interação
# =========================
if [ "$1" == "click" ]; then
    gnome-terminal -- bash -c "
    clear
    rows=\$(tput lines)
    cols=\$(tput cols)

    center() {
        local str=\"\$1\"
        local len=\${#str}
        local padding=\$(( (cols - len) / 2 ))
        printf '%*s%s\n' \$padding '' \"\$str\"
    }

    # Top padding
    for i in \$(seq 1 \$((rows/8))); do echo ''; done

    # Header
    center \"${BOLD}${CYAN}╔══════════════════════════════════════════╗${RESET}\"
    center \"${BOLD}${CYAN}║       🔔 Atualizações Disponíveis        ║${RESET}\"
    center \"${BOLD}${CYAN}╚══════════════════════════════════════════╝${RESET}\"
    echo ''

    # APT
    if [ $apt_count -gt 0 ]; then
        center \"${YELLOW}┌───────── Pacotes APT (${apt_count}) ─────────┐${RESET}\"
        center \"${BOLD}Pacote                                   Versão${RESET}\"
        center \"--------------------------------------------------\"
        echo \"$apt_updates\" | awk -v cols=\$cols '{printf \"%*s%-40s %-15s%*s\n\", (cols-55)/2, \"\", \$1, \$2, (cols-55)/2, \"\"}'
        center \"${YELLOW}└──────────────────────────────────────────┘${RESET}\"
        echo ''
    else
        center \"${GREEN}✅ Nenhum pacote APT para atualizar.${RESET}\"
        echo ''
    fi

    # Flatpak
    if [ $flatpak_count -gt 0 ]; then
        center \"${MAGENTA}┌─────── Pacotes Flatpak (${flatpak_count}) ───────┐${RESET}\"
        echo \"$flatpak_updates\" | awk -v cols=\$cols '{printf \"%*s%-50s%*s\n\", (cols-50)/2, \"\", \$1, (cols-50)/2, \"\"}'
        center \"${MAGENTA}└──────────────────────────────────────────┘${RESET}\"
        echo ''
    else
        center \"${GREEN}✅ Nenhum pacote Flatpak para atualizar.${RESET}\"
        echo ''
    fi

    # Pergunta
    center \"${BOLD}Deseja atualizar todos os pacotes? (sim/não)${RESET}\"
    read -p '> ' resp

    if [[ \$resp == 'sim' ]]; then
        center \"${BLUE}🔄 Atualizando APT...${RESET}\"
        sudo apt update && sudo apt upgrade -y
        center \"${BLUE}🔄 Atualizando Flatpak...${RESET}\"
        flatpak update -y
        center \"${GREEN}✅ Atualização concluída!${RESET}\"
    else
        center \"${RED}❌ Nenhuma atualização realizada.${RESET}\"
    fi

    # Bottom padding
    for i in \$(seq 1 \$((rows/8))); do echo ''; done
    center \"${CYAN}Pressione Enter para fechar...${RESET}\"
    read
    "
fi