#!/usr/bin/env bash

# Cores ANSI
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
BOLD="\e[1m"
RESET="\e[0m"

# Função para listar APT updates
list_apt_updates() {
    apt list --upgradable 2>/dev/null | tail -n +2
}

# Função para listar Flatpak updates
list_flatpak_updates() {
    flatpak remote-ls --updates 2>/dev/null
}

apt_updates=$(list_apt_updates)
apt_count=$(echo "$apt_updates" | grep -c .)

flatpak_updates=$(list_flatpak_updates)
flatpak_count=$(echo "$flatpak_updates" | grep -c .)

total=$((apt_count + flatpak_count))

# Ícone para Polybar
if [ "$total" -gt 0 ]; then
    echo "󰏗 $total"
else
    exit 0
fi

# Interação ao clicar
if [ "$1" == "click" ]; then
    gnome-terminal -- bash -c "
        clear
        echo -e '${BOLD}${CYAN}=== Atualizações Disponíveis ===${RESET}\n'

        # APT
        if [ $apt_count -gt 0 ]; then
            echo -e '${YELLOW}Pacotes APT (${apt_count}):${RESET}'
            printf '%-40s %-10s\n' 'Pacote' 'Versão'
            echo '---------------------------------------------'
            echo \"$apt_updates\" | awk -F/ '{printf \"%-40s %-10s\\n\", \$1, \$2}'
            echo ''
        else
            echo -e '${GREEN}Nenhum pacote APT para atualizar.${RESET}\n'
        fi

        # Flatpak
        if [ $flatpak_count -gt 0 ]; then
            echo -e '${YELLOW}Pacotes Flatpak (${flatpak_count}):${RESET}'
            echo \"$flatpak_updates\" | awk '{printf \"%-40s\\n\", \$1}'
            echo ''
        else
            echo -e '${GREEN}Nenhum pacote Flatpak para atualizar.${RESET}\n'
        fi

        echo -e '${BOLD}Deseja atualizar todos os pacotes? (sim/não)${RESET}'
        read -p '> ' resp

        if [[ \$resp == 'sim' ]]; then
            echo -e '\n${BLUE}Atualizando APT...${RESET}'
            sudo apt update && sudo apt upgrade -y
            echo -e '\n${BLUE}Atualizando Flatpak...${RESET}'
            flatpak update -y
            echo -e '\n${GREEN}✅ Atualização concluída!${RESET}'
        else
            echo -e '\n${RED}❌ Nada foi alterado.${RESET}'
        fi

        echo -e '\nPressione Enter para fechar...'
        read
    "
fi