#!/usr/bin/env bash

while true; do
    workspaces=$(i3-msg -t get_workspaces | python3 -c "
import json, sys
ws = json.load(sys.stdin)
names = [w['name'] for w in ws]
for i in ['1','2','3','4','5']:
    if i not in names:
        print(i)
")
    for ws in $workspaces; do
        current=$(i3-msg -t get_workspaces | python3 -c "
import json, sys
ws = json.load(sys.stdin)
print([w['name'] for w in ws if w['focused']][0])
")
        i3-msg "workspace $ws" > /dev/null
        i3-msg "workspace $current" > /dev/null
    done
    sleep 2
done