#!/usr/bin/env bash

# Cores ANSI
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"
BOLD="\e[1m"

# Verifica updates
apt_updates=$(apt list --upgradable 2>/dev/null | grep -v Listing)
apt_count=$(echo "$apt_updates" | wc -l)

flatpak_updates=$(flatpak remote-ls --updates 2>/dev/null)
flatpak_count=$(echo "$flatpak_updates" | wc -l)

total=$((apt_count + flatpak_count))

# Mostrar ícone no Polybar
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

        if [ $apt_count -gt 0 ]; then
            echo -e '${YELLOW}Pacotes APT (${apt_count}):${RESET}'
            echo -e '${apt_updates//,/\\n}'
            echo ''
        else
            echo -e '${GREEN}Nenhum pacote APT para atualizar.${RESET}\n'
        fi

        if [ $flatpak_count -gt 0 ]; then
            echo -e '${YELLOW}Pacotes Flatpak (${flatpak_count}):${RESET}'
            echo -e '${flatpak_updates//,/\\n}'
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