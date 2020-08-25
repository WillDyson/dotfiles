#!/bin/bash
# tmux helper.  http://unix.stackexchange.com/a/325816/119298
if [[ $(tmux show-window-option synchronize-panes) == *on ]]
then    tmux set-window-option -q synchronize-panes off
        restore="tmux set-window-option -q synchronize-panes on"
fi
tmux list-panes -F  '#{window_index} #{pane_index}' |
while read winid pane
do    tmux send-keys -t $winid.$pane $pane
done
$restore
