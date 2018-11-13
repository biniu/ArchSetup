#!/bin/env bash

source $(dirname "$0")/utils.sh;
source $(dirname "$0")/config.sh;

function update {
    sudo pacman -Syyu
    yaourt -Syu --aur
}

function install_oh_my_zsh {
    logger "Install oh-my-zsh" 0;

    rm -rf ~/.oh-my-zsh
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k;

    cp zshrc ~/.zshrc
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
        'visual-studio-code-bin'
    );

    # for pkg in "${EDITORS_LIST[@]}"; do
    #     yaourt_wrap "$pkg";
    # done
    check_if_installed_sys "${EDITORS_LIST[@]}";
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
        'ctags'
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
        'cpplint'
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
        'ipython'
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
        'paramiko'
        'scp'
        'gitpython'
        'autopep8'
        'importmagic'
        'epc'
        'nose'
        'rednose'
        'sphinx'
    );

    for pkg in "${PIP_MODULES[@]}"; do
        pip_wrap "$pkg";
    done
}

function install_other {
    logger "Install other packages" 0
    OTHER_LIST=(
        'dia'
        'docker'
        'docker-compose'
        'arandr'
        'nemo'
        'otf-ipafont'    # Japanese fonts
        'conky'
        'i3-gaps'
        'i3blocks'
        'spotify'
        'dropbox'
        'nemo-dropbox'
        'oomox'
        'speedcrunch'
        'bc'
        'epdfview'
        'rsync'
        'gperf'         # needed by icons-in-terminal
        'morc_menu'
        'perl-anyevent-i3'
        'pandoc'
        'anki'
        'gnome-mplayer'
        'filezilla'
        'rofi'
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

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

function show_help {
  echo "Usage: $0 [option...]"
  echo ""
  echo "    -a               install everythink"
  echo "    -e               install editors"
  echo "    -b               install browsers"
  echo "    -c               install command line tools"
  echo "    -d               install basic dev tools"
  echo "    -q               install C++/C tools"
  echo "    -p               install python tools"
  echo "    -o               install other"
  echo "    -z               install oh-my-zsh"
  echo "    -v               install Virtual Box"
  echo ""
}

while getopts "h?aebcdqpozv" opt; do
    case "$opt" in
    h|\?)
      show_help
      exit 0
      ;;
  a)  echo "install everythink"
      install_editors;
      install_browers;
      install_cmd_tools;
      install_basic_dev_tools;
      install_cpp_dev_tools;
      install_python_dev_tools;
      install_other;
      install_oh_my_zsh;
      install_vbox;
      ;;
  e)  echo "install editors"
      install_editors;
      ;;
  b)  echo "install browsers"
      install_browers;
      ;;
  c)  echo "install command line tools"
      install_cmd_tools;
      ;;
  d)  echo "install basic dev tools"
      install_basic_dev_tools;
      ;;
  q)  echo "install C++/C tools"
      install_cpp_dev_tools;
      ;;
  p)  echo "install python tools"
      install_python_dev_tools;
      ;;
  o)  echo "install other"
      install_other;
      ;;
  z)  echo "install oh-my-zsh"
      install_oh_my_zsh;
      ;;
  v)  echo "install Virtual Box"
      install_vbox;
      ;;
    esac
done
