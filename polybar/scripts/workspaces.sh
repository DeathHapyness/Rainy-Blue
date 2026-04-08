#!/usr/bin/env bash

focused=$(i3-msg -t get_workspaces | python3 -c "
import json, sys
ws = json.load(sys.stdin)
print([w['name'] for w in ws if w['focused']][0])
")

occupied=$(i3-msg -t get_workspaces | python3 -c "
import json, sys
ws = json.load(sys.stdin)
print(' '.join([w['name'] for w in ws if not w['focused']]))
")

output=""
for i in 1 2 3 4 5; do
    if [ "$i" = "$focused" ]; then
        output="$output %{F#ffffff}%{B#5e81ac} $i %{B-}%{F-}"
    elif echo "$occupied" | grep -qw "$i"; then
        output="$output %{F#88c0d0} $i %{F-}"
    else
        output="$output %{F#4c566a} $i %{F-}"
    fi
done

echo "$output"
