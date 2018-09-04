#!/bin/bash

echo "" > install_yaourt.log

function yaourt_wrap {
    echo "Installing [$1]" >> install_yaourt.log
    echo "Installing [$1]"
    yaourt -S $1 --noconfirm  &>>  install_yaourt.log
    if [ $? == 0 ]; then
        echo "Instllation of [$1] OK"
        echo "***************************" >> install_yaourt.log
        echo "Instllation of [$1] OK" >> install_yaourt.log
    else
        echo "Instllation of [$1] ERROR"
        echo "***************************" >> install_yaourt.log
        echo "Instllation of [$1] ERROR" >> install_yaourt.log
    fi
}

install_list=(
    'sublime-text-dev'
    'vivaldi'
    'rats'
    'vera++'
    'spotify'
    'gitkraken'
    'dropbox'
    'nemo-dropbox'
    'oomox'
    'git-flow-completion-git'
    'signal-desktop-beta'
)

for pkg in "${install_list[@]}"; do 
    yaourt_wrap $pkg
done
