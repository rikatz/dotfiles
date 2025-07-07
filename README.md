# Ricardo's dotfiles managed by Chezmoi

These are my dotfiles. I use [chezmoi](https://www.chezmoi.io/) to manage them, so 
some stuff may not make sense here.

## Running:
* Install Chezmoi 
```
sudo pacman -S chezmoi
```

Change to your preferred distro, as on [here](https://www.chezmoi.io/install/)

* Apply the configurations from my repo and branch
```
chezmoi init --branch chezmoi-files --apply git@github.com:rikatz/dotfiles.git
```

## Structure:
* `run_onchange_install-os.sh.tmpl` - Template of a shell script that is executed as part of dotfiles creation.
This file is executed just when one of the files mentioned on lines that contains `{{ sha256sum }}` are changed.
It is used to perform the installation of required packages
* `install/*` - Directory that contain scripts and packages to be installed. These files are **NOT MANAGED BY CHEZMOI** (eg.: they 
are not created on my home directory, and are accessible just from the source directory)
* `*_dot_*` - dotfiles managed by chezmoi, should not be changed manually (unless they are templates)

## Support / TODO
Right now my dotfiles are usable only on Archlinux. Other OS support may come once I need them