#!/usr/bin/env bash

opcoes="󰐥 Desligar\n󰜉 Reiniciar\n󰤄 Suspender\n󰍃 Sair"

escolha=$(echo -e "$opcoes" | rofi -dmenu -i -p "" -l 4 -width 15 -bw 2 -location 0)

case "$escolha" in
    *Desligar) systemctl poweroff ;;
    *Reiniciar) systemctl reboot ;;
    *Suspender) systemctl suspend ;;
    *Sair) i3-msg exit ;;
esac
