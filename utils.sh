#!/bin/bash

source $(dirname "$0")/config.sh

RED='\033[0;31m' # Red
YEL='\033[0;33m' # Yellow
NC='\033[0m' # No Color
#logger SUCCES  0
#logger WARNING 1
#logger FAIL    2
function logger {
    if [ $2 == 0 ]; then
	 printf "${1}\n"|tee -a log.txt;
    elif [ $2 == 1 ]; then
	printf "${YEL}${1}${NC}\n"|tee -a log.txt
    elif [ $2 == 2 ]; then
	printf "${RED}${1}${NC}\n"|tee -a log.txt
    fi
}

function log_break {
    printf "*%.0s" {1..80} >> log.txt;
    printf "\\n" >>  log.txt;
}

function pacman_wrap {
    logger "Try to install [$1]" 0;
    log_break;
    if (pacman -Q "$1" &>/dev/null); then
        logger "Already installed [$1]" 0;
	log_break;
        return
    fi


    if (pacman -S "$1" --noconfirm  &>> log.txt); then
        logger "Instllation of [$1] OK" 0;
	log_break;
    else
        logger "Instllation of [$1] ERROR" 2;
        log_break;
    fi
}

function yaourt_wrap {
    logger "Try to install [$1]" 0;
    log_break;
    if (yaourt -Q "$1" &>/dev/null); then
        logger "Already installed [$1]" 0;
	log_break;
        return
    fi

    if (yaourt -S "$1" --noconfirm  &>> log.txt); then
        logger "Instllation of [$1] OK" 0;
	log_break;
    else
        logger "Instllation of [$1] ERROR" 2;
        log_break;
    fi
}

function pip_wrap {
    logger "Try to install python module [$1]" 0;
    log_break;
    if (pip list |grep -i "$1" &>/dev/null); then
        logger "Python module already installed [$1]" 0;
	log_break;
        return
    fi

    if (pip install "$1"  &>> log.txt); then
        logger "Instllation of [$1] OK" 0;
	log_break;
    else
        logger "Instllation of [$1] ERROR" 2;
        log_break;
    fi
}
