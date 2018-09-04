#!/bin/bash

pacman -Syyu --noconfirm

echo "" > install.log

function pacman_wrap {
    echo "Installing [$1]" >> install.log
    echo "Installing [$1]"

    if (pacman -Q $1 &>/dev/null); then
        echo "Already installed [$1]"
        echo "Already installed [$1]" >> install.log
        echo "***************************" >> install.log
        return
    fi

    pacman -S $1 --noconfirm  &>> install.log
    if [ $? == 0 ]; then
        echo "Instllation of [$1] OK"
        echo "***************************" >> install.log
        echo "Instllation of [$1] OK" >> install.log
    else
        echo "Instllation of [$1] ERROR"
        echo "***************************" >> install.log
        echo "Instllation of [$1] ERROR" >> install.log
    fi
}

function install_oh_my_zsh()
{
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    echo "ZSH_THEME=\"powerlevel9k/powerlevel9k\"" >> ~/.zshrc
}

function install_vbox()
{
    pacman_wrap virtualbox
    pacman_wrap virtualbox-host-modules-arch
    pacman_wrap linux-headers

    echo "Enable vbox kernel modules"
    modprobe vboxdrv
    modprobe vboxnetadp
    modprobe vboxnetflt
    modprobe vboxpci
}



install_list=(
# editors
    'vim'
    'emacs'

# CMD tools
    'mc'
    'tmux'
    'terminator'
    'guake'
    'htop'
# Internet
    'firefox'
    'chromium'
    'thunderbird'
# DEV
    'python'
    'python-pip'
    'python2'
    'python2-pip'
    'make'
    'cmake'
    'gdb'
    'gcc'
    'git'
    'clang'
    'clang-tools-extra'
    'boost'
    'boost-libs'
    'cppcheck'
    'valgrind'
    'zeal'
    # Other
    'dia'
    'docker'
    'docker-compose'
    'xmind'
    'arandr'
    'nemo'
    'otf-ipafont'    # Japanese fonts
)


for pkg in "${install_list[@]}"; do
    pacman_wrap $pkg
done

install_oh_my_zsh;
install_vbox;
