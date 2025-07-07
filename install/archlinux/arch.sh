#!/usr/bin/env bash
set -euo pipefail
set -x


# Arch Linux specifics
arch_install() {
    PACMAN_PKG="${1:-$(pwd)/archlinux/pacman.txt}"
    YAY_PKG="${2:-$(pwd)/archlinux.yay.txt}"


    if [ ! -f /etc/arch-release ]; then
        echo "This is not an Arch Linux"
        exit 1
    fi


    echo "Installing Arch Linux packages"
    cat ${PACMAN_PKG} | sudo pacman -Sy --needed --noconfirm -

    echo "Installing extra packages"
    cat ${YAY_PKG} | yay -Sy --needed --noconfirm --answerclean None --answerdiff None -

    sudo usermod -s "$(which zsh)" "$USER"
}
