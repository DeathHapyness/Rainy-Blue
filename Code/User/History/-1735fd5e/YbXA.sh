#!/usr/bin/env bash

# --- Configurações e Cores ---
RESET="\e[0m"
BOLD="\e[1m"
CYAN="\e[36m"
GREEN="\e[32m"
YELLOW="\e[33m"
MAGENTA="\e[35m"
BLUE="\e[34m"
RED="\e[31m"
UNDERLINE="\e[4m"

# --- Funções de Dados ---
# Captura lista de updates APT: Nome e Versão
get_apt_updates() {
    apt list --upgradable 2>/dev/null | grep "/" | awk -F/ '{printf "%-35s %s\n", $1, $2}' | sed 's/\[.*\]//'
}

# Captura lista de updates Flatpak: Nome/ID
get_flatpak_updates() {
    flatpak remote-ls --updates --columns=application,version 2>/dev/null
}

# --- Lógica de Exibição na Polybar ---
if [ "$1" != "click" ]; then
    # Fazemos uma contagem rápida
    apt_c=$(apt list --upgradable 2>/dev/null | grep -c "/")
    flat_c=$(flatpak remote-ls --updates 2>/dev/null | wc -l)
    total=$((apt_c + flat_c))

    if [ "$total" -gt 0 ]; then
        echo "%{F#6272a4}󰏗 %{F-}$total"
    else
        echo "%{F#50fa7b}󰄬%{F-}" # Ícone de check se estiver tudo ok
    fi
    exit 0
fi

# --- Interface de Interação (Ao Clicar) ---
gnome-terminal -- bash -c "
    echo -e '${CYAN}${BOLD}╭──────────────────────────────────────────────────────────╮${RESET}'
    echo -e '${CYAN}${BOLD}│             🔔 CENTRAL DE ATUALIZAÇÕES DO SISTEMA        │${RESET}'
    echo -e '${CYAN}${BOLD}╰──────────────────────────────────────────────────────────╯${RESET}\n'

    # Captura os dados uma vez para o terminal
    echo -e '${BLUE}🔍 Verificando repositórios...${RESET}'
    apt_list=\$(apt list --upgradable 2>/dev/null | grep \"/\")
    apt_count=\$(echo \"\$apt_list\" | grep -c \"/\" || echo 0)
    
    flat_list=\$(flatpak remote-ls --updates --columns=application,version 2>/dev/null)
    flat_count=\$(echo \"\$flat_list\" | wc -l || echo 0)

    # Exibição APT
    if [ \"\$apt_count\" -gt 0 ]; then
        echo -e '${YELLOW}${BOLD}📦 Pacotes APT (\$apt_count)${RESET}'
        echo -e '${UNDERLINE}%-40s %-20s${RESET}' 'Nome do Pacote' 'Versão Disponível'
        echo \"\$apt_list\" | awk -F/ '{split(\$2, a, \" \"); printf \"%-40s %-20s\\n\", \$1, a[2]}'
        echo ''
    else
        echo -e '${GREEN}✅ Sistema base (APT) atualizado.${RESET}\n'
    fi

    # Exibição Flatpak
    if [ \"\$flat_count\" -gt 0 ]; then
        echo -e '${MAGENTA}${BOLD}󰏆  Flatpaks (\$flat_count)${RESET}'
        echo -e '${UNDERLINE}%-40s %-20s${RESET}' 'ID do Aplicativo' 'Versão'
        echo \"\$flat_list\"
        echo ''
    else
        echo -e '${GREEN}✅ Todos os Flatpaks atualizados.${RESET}\n'
    fi

    total=\$((apt_count + flat_count))

    if [ \"\$total\" -gt 0 ]; then
        echo -ne '${BOLD}Deseja aplicar todas as atualizações? (s/N): ${RESET}'
        read resp
        if [[ \"\$resp\" =~ ^[Ss]$ ]]; then
            echo -e '\n${BLUE}🔄 Iniciando manutenção...${RESET}'
            sudo apt update && sudo apt upgrade -y
            flatpak update -y
            echo -e '\n${GREEN}${BOLD}🎉 Tudo pronto! Sistema atualizado.${RESET}'
        else
            echo -e '\n${RED}⚠️  Operação cancelada.${RESET}'
        fi
    else
        echo -e '${GREEN}Nada para fazer aqui!${RESET}'
    fi

    echo -e '\n${CYAN}Pressione Enter para sair...${RESET}'
    read
"