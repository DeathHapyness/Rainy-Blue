#!/usr/bin/env bash

# =========================
# Cores e formatação
# =========================
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

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
# Interação ao clicar
# =========================
if [ "$1" == "click" ]; then
    gnome-terminal -- bash -c "
        clear
        # Detect terminal size
        rows=\$(tput lines)
        cols=\$(tput cols)

        # Function to center text horizontally
        center() {
            local str=\"\$1\"
            local len=\${#str}
            local padding=\$(( (cols - len) / 2 ))
            printf '%*s%s\n' \$padding '' \"\$str\"
        }

        # Print empty lines to center vertically
        top_padding=\$((rows / 6))
        for i in \$(seq 1 \$top_padding); do echo ''; done

        # ===== Dashboard Header =====
        center '${BOLD}${CYAN}╔════════════════════════════════════════════╗${RESET}'
        center '${BOLD}${CYAN}║        🔄 Atualizações Disponíveis         ║${RESET}'
        center '${BOLD}${CYAN}╚════════════════════════════════════════════╝${RESET}\n'

        # ===== APT Updates =====
        if [ $apt_count -gt 0 ]; then
            center '${YELLOW}┌───────────── Pacotes APT (${apt_count}) ─────────────┐${RESET}'
            center \"${BOLD}Pacote                                   Versão${RESET}\"
            center '---------------------------------------------------------'
            echo \"$apt_updates\" | awk -v cols=\$cols '{printf \"%*s%-40s %-15s%*s\n\", (cols-55)/2, \"\", \$1, \$2, (cols-55)/2, \"\"}'
            center '${YELLOW}└───────────────────────────────────────────────┘${RESET}\n'
        else
            center '${GREEN}✅ Nenhum pacote APT para atualizar.${RESET}\n'
        fi

        # ===== Flatpak Updates =====
        if [ $flatpak_count -gt 0 ]; then
            center '${MAGENTA}┌────────── Pacotes Flatpak (${flatpak_count}) ──────────┐${RESET}'
            echo \"$flatpak_updates\" | awk -v cols=\$cols '{printf \"%*s%-50s%*s\n\", (cols-50)/2, \"\", \$1, (cols-50)/2, \"\"}'
            center '${MAGENTA}└───────────────────────────────────────────────┘${RESET}\n'
        else
            center '${GREEN}✅ Nenhum pacote Flatpak para atualizar.${RESET}\n'
        fi

        # ===== Pergunta de atualização =====
        center '${BOLD}Deseja atualizar todos os pacotes? (sim/não)${RESET}'
        read -p '> ' resp

        if [[ \$resp == 'sim' ]]; then
            center '\n${BLUE}🔄 Atualizando APT...${RESET}'
            sudo apt update && sudo apt upgrade -y
            center '\n${BLUE}🔄 Atualizando Flatpak...${RESET}'
            flatpak update -y
            center '\n${GREEN}✅ Atualização concluída!${RESET}'
        else
            center '\n${RED}❌ Nenhuma atualização realizada.${RESET}'
        fi

        # Bottom padding to keep dashboard central
        bottom_padding=\$((rows / 6))
        for i in \$(seq 1 \$bottom_padding); do echo ''; done

        center '${CYAN}Pressione Enter para fechar...${RESET}'
        read
    "
fi