#!/bin/bash

# Configuração minimalista para não dar conflito
config_file="/tmp/polybar_cava_config"
cat <<EOF > "$config_file"
[general]
bars = 10
sleep = 0.7

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Limpa instâncias antigas para evitar travamento
killall -q cava

# Executa o cava e mapeia os caracteres de bloco
cava -p "$config_file" | while read -r line; do
    echo "$line" | sed 's/0/ /g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g'
done