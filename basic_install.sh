#!/bin/bash

source $(dirname "$0")/utils.sh;
source $(dirname "$0")/config.sh;

function install_oh_my_zsh {
    logger "Install oh-my-zsh" 0;
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)";
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k;
    echo "ZSH_THEME=\"powerlevel9k/powerlevel9k\"" >> ~/.zshrc;
}

function install_vbox {
    logger "Install Virtual Box" 0;
    yaourt_wrap virtualbox;
    yaourt_wrap virtualbox-host-modules-archl
    yaourt_wrap linux-headers;

    logger "Enable vbox kernel modules" 0;
    modprobe vboxdrv;
    modprobe vboxnetadp;
    modprobe vboxnetflt;
    modprobe vboxpci;
}

function install_editors {
    logger "Install basic editors" 0
    EDITORS_LIST=(
        'emacs'
        'vim'
        'atom'
        'sublime-text-dev'
    );

    for pkg in "${EDITORS_LIST[@]}"; do
        yaourt_wrap "$pkg";
    done
}

function install_cmd_tools {
    logger "Install basic cmd tools" 0
    CMD_TOOLS_LIST=(
        'mc'
        'tmux'
        'terminator'
        'guake'
        'htop'
    );

    for pkg in "${CMD_TOOLS_LIST[@]}"; do
        yaourt_wrap "$pkg";
    done
}

function install_browers {
    logger "Install browsers" 0
    BROWSERS_LIST=(
        'firefox'
        'chromium'
    );

    for pkg in "${BROWSERS_LIST[@]}"; do
        yaourt_wrap "$pkg";
    done
}

function install_basic_dev_tools {
    logger "Install basic dev tools" 0
    BASIC_DEV_TOOLS_LIST=(
        'git'
        'zeal'
        'gitkraken'
#        'git-flow-completion-git' # - PACKAGE TO CHECK
        'meld'
    );

    for pkg in "${BASIC_DEV_TOOLS_LIST[@]}"; do
        yaourt_wrap "$pkg";
    done
}

function install_cpp_dev_tools {
    logger "Install basic cpp tools" 0
    CPP_DEV_LIST=(
        'gcc'
        'gdb'
        'clang'
        'lld'
        'llvm'
        'zapcc'
        'make'
        'cmake'
        'boost'
        'boost-libs'
        'cppcheck'
        'valgrind'
        'rats'
        'vera++'
    );

    for pkg in "${CPP_DEV_LIST[@]}"; do
        yaourt_wrap "$pkg";
    done
}

function install_python_dev_tools {
    logger "Install basic python tools" 0
    PYTHON_DEV_TOOLS=(
        'python'
        'python-pip'
        'python2'
        'python2-pip'
    );

    for pkg in "${PYTHON_DEV_TOOLS[@]}"; do
        yaourt_wrap "$pkg";
    done

    PIP_MODULES=(
        'pylint'
        'django'
        'virtualenv'
        'virtualenvwrapper'
        'flake8'
        'pyflakes'
    );

    for pkg in "${PIP_MODULES[@]}"; do
        pacman_wrap "$pkg";
    done
}

function install_other {
    logger "Install other packages" 0
    OTHER_LIST=(
        'dia'
        'docker'
        'docker-compose'
        'xmind'
        'arandr'
        'nemo'
        'otf-ipafont'    # Japanese fonts
        'conky'
        'i3'
        'i3blocks'
        'spotify'
        'dropbox'
        'nemo-dropbox'
        'oomox'
        'gperf'         # needed by icons-in-terminal
    );

    for pkg in "${OTHER_LIST[@]}"; do
        yaourt_wrap "$pkg";
    done
}

function sys_update {
    logger "Update the system" 0
}

function get_emacs_config {
    logger "Get emacs config from github" 0;
    if (git clone https://github.com/biniu/emacsSetup.git ~/.emacs &>>LOG_FILE); then
        logger "Configure emacs OK" 0;
    else
        logger "Configure emacs ERROR" 0;
    fi

}


install_editors;
install_browers;
install_cmd_tools;
install_basic_dev_tools;
install_cpp_dev_tools;
install_python_dev_tools;
install_oh_my_zsh;
install_vbox;
