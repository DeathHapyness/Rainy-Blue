#!/usr/bin/env bash

# Verifica updates
apt_updates=$(apt list --upgradable 2>/dev/null | grep -v Listing)
apt_count=$(echo "$apt_updates" | wc -l)

flatpak_updates=$(flatpak remote-ls --updates 2>/dev/null)
flatpak_count=$(echo "$flatpak_updates" | wc -l)

total=$((apt_count + flatpak_count))

if [ "$total" -gt 0 ]; then
    echo "󰏗 $total"
else
    exit 0
fi

if [ "$1" == "click" ]; then
    gnome-terminal -- bash -c "
        echo 'Pacotes apt disponíveis:'; 
        echo '$apt_updates'; 
        echo ''; 
        echo 'Pacotes flatpak disponíveis:'; 
        echo '$flatpak_updates'; 
        echo '';
        read -p 'Deseja atualizar todos os pacotes? (sim/não) ' resp;
        if [[ \$resp == 'sim' ]]; then
            sudo apt update && sudo apt upgrade -y;
            flatpak update -y;
            echo 'Atualização concluída!';
        else
            echo 'Nada foi alterado.';
        fi;
        read -p 'Pressione Enter para fechar...'
    "
fi