#!/usr/bin/env bash

# Terminar instâncias já em execução
killall -q polybar

# Aguardar até que os processos tenham sido encerrados
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Iniciar a barra "top" (substitua 'top' pelo nome da sua barra no config.ini)
polybar main &

echo "Polybar iniciada..."
