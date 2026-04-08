#!/bin/sh

#!/bin/bash

# Crie um arquivo de config temporário para o CAVA da barra
config_file="/tmp/polybar_cava_config"
echo "
[general]
bars = 10
sleep = 0.7

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
" > "$config_file"

# Executa o cava e transforma a saída em barras visuais
cava -p "$config_file" | while read -r line; do
    echo "$line" | sed 's/0/ /g; s/1/▂/g; s/2/▃/g; s/3/▄/g; s/4/▅/g; s/5/▆/g; s/6/▇/g; s/7/█/g'
done