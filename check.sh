#!/bin/sh

check_os() {
    OS=$(uname)
    OS_VER=$(cat /etc/issue | awk '{print $2}')

    if [ ${OS} != "Linux" ];
    then
        echo "Operation System is not Linux"
        exit 1
    fi

    if [ OS_VER == 14.04 ];
    then
        echo "version not match 14.04"
        exit 1
    fi
}

check_source() {
    echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe " > /etc/apt/sources.list
    echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe " >> /etc/apt/sources.list
    echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe " >> /etc/apt/sources.list
    echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe " >> /etc/apt/sources.list
    echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe " >> /etc/apt/sources.list
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty main restricted universe " >> /etc/apt/sources.list
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-security main restricted universe " >> /etc/apt/sources.list
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe " >> /etc/apt/sources.list
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe " >> /etc/apt/sources.list
    echo "deb-src http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe " >> /etc/apt/sources.list
    sudo apt-get update
}


check_packages() {
    require_packages=(
        "build-essential"
        "autotools-dev"
        "automake" 
        "pkg-config" 
        "libevent-dev" 
        "libncurses-dev" 
        "libssl-dev" 
        "libcurl4-openssl-dev"
        "curl"
        "wget"
        "libclang-dev"
        "python-dev"
        "silversearcher-ag"
        "git-core"
        "tmux"
        "mutt"
        "irssi"
    )

    sudo apt-get autoclean
    for pkg in "${require_packages[@]}"
    do
        if [ $(dpkg-query -W -f='ok' ${pkg} 2>&- /dev/null | grep -c 'ok') == 0 ];
        then
            sudo apt-get install -f -y ${pkg}
        fi
    done
}

check_os && check_source && check_packages
