set -U fish_user_paths /home/rkatz/bin $fish_user_paths

starship init fish | source
tmux attach -t default || tmux new -s default
