#!/bin/sh

CURRENT_DIR=$(pwd)

# ************************
# Tmux
# ************************
tmux_config() {
    # link tmux config file
    tmux_conf_path=${CURRENT_DIR}'/tmux/tmux.conf'

    if [ -f "${tmux_conf_path}" ]; then
        echo "remove ~/.tmux.conf, link new config file at "${CURRENT_DIR}'/tmux/tmux.conf'
        rm -rf ~/.tmux.conf
    fi

    ln -s $tmux_conf_path ~/.tmux.conf
    echo 'link tmux config file finished'
}

tmux_config
