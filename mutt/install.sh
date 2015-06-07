#!/bin/bash


install_mutt() {

    CURRENT_DIR=$(pwd)

    if [ -e "${CURRENT_DIR}/mailbox.sh" ];
    then
        . ./mailbox.sh
    else
        echo 'mailbox.conf not exists, install mutt fail'
    fi

}

install_mutt
