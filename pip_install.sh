#!/bin/bash

function pip_wrap {
    echo "Installing [$1]" >> pip.log
    echo "Installing [$1]"

    pip install $1 &>> pip.log
    if [ $? == 0 ]; then
        echo "Instllation of [$1] OK"
        echo "***************************" >> pip.log
        echo "Instllation of [$1] OK" >> pip.log
    else
        echo "Instllation of [$1] ERROR"
        echo "***************************" >> pip.log
        echo "Instllation of [$1] ERROR" >> pip.log
    fi
}

install_list=(
    'pylint'
    'django'
)

for pkg in "${install_list[@]}"; do
    pip_wrap $pkg
done
