#!/usr/bin/env bash
set -euo pipefail

# Fedora Linux specifics
dnf_install() {
    DNF_PKG="${1:-$(pwd)/fedora/dnf.txt}"
    COPR_PKG="${2:-$(pwd)/fedora/copr.txt}"

    if [ ! -f /etc/fedora-release ]; then
        echo "This is not a Fedora Linux"
        exit 1
    fi

    echo "Enabling COPR repos"
    while IFS= read -r line; do
      sudo dnf copr enable -y $line
    done < "$COPR_PKG"

    echo "Installing Fedora Linux packages"
    sudo dnf install -y $(cat $DNF_PKG)

    # Managed fedora doesn't work, need a different way to change it
    # sudo usermod -s "$(which zsh)" "$USER"
}

