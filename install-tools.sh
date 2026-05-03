#!/bin/bash
#
#  Copyright (c) 2017-2026 Martin Jablečník
#  Authors: Martin Jablečník
#  Description: Script for install and setup my tools
#
#

set -e

###    VARIABLES    ###
EMAIL=martin.jablecnik@email.cz
USER_NAME="Martin Jablečník"
HOSTNAME=test-localhost
USER=martin
USER_HOME="/home/${USER}"
if [[ -n ${2} ]]; then HOSTNAME=${2}; fi


#######################


    
###    FUNCTIONS    ###

function setup_configs {
  echo "Download configs"
    #if [[ -e tool-configs ]]; then rm -rf tool-configs; fi
    #git clone https://github.com/mjablecnik/tool-configs.git
    (
    cd ${1}-configs/
    
    #cp bin/upstart /etc/upstart
    #cp martin/roles/common/files/upstart.service /lib/systemd/system/
    
    cp -r .config .tmux .tmux.conf .vim .vimrc .zshrc /root
    cp -r .config .tmux .tmux.conf .vim .vimrc .zshrc .kiro .Xresources ${USER_HOME}
    if [[ ${1} == 'local' ]]; then
      cp -r .local/nvim ${USER_HOME}/.local
    fi
    #cd - && rm -r tool-configs
    
    # cp 10-evdev.conf /usr/share/X11/xorg.conf.d/10-evdev.conf
    
    # ## Install Pathogen
    # mkdir -p ~/.vim/autoload ~/.vim/bundle 
    # curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    
    ## Install Tmux Plugin Manager
    mkdir -p ${USER_HOME}/.tmux/plugins
    git clone https://github.com/mjablecnik/tpm.git ${USER_HOME}/.tmux/plugins/tpm
    
    chown -R ${USER}:${USER} ${USER_HOME}
    )
}


function setup_zsh {
  echo "Setup ZSH shell.."
    chsh -s /usr/bin/zsh root
    chsh -s /usr/bin/zsh ${USER}
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}


function setup_git {
  echo "Setup git.."
    git config --global user.name "${1}"
    git config --global user.email "${EMAIL}"
    git config --system core.editor /usr/bin/vim
    git config --global pager.branch false
    git config --global rebase.autoSquash true
    git config --global rerere.enabled true
    git config --global merge.conflictStyle diff3
}


function setup_hostname {
  echo "Setup hostname.."
    hostname ${HOSTNAME}
    echo $(hostname) > /etc/hostname
}


function setup_ssh {
  echo "Setup ssh.."
    mkdir -p ${USER_HOME}/.ssh/
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoUVmz1z0iDutSMGNyQ7syIw/WUp+mUqyoY+4gS6lCmehJMEXMeUeZ4ZwO0/25hWxnOqOZoMwDoaZGJcNMxCfiuZkFx3ycNLaAZPWtwcD9KuV08aNzffLz7O1TVR3+pML1KTokHcs3q1QMTTrBg6FCqWFoTjgP2Ma9jqcbTXs+QBSnQOtDUtqGk3qjw94A7US24y6Frs/1RcIn2RdnL/G1PQv/uTt8B0lMwPLtovOdrH7kkQ1ZpaL5rYmPkD298lSybc+6/Rsr/HJKEibSXNbygiUz4rLSrRR0SFqrH1L9e6JI8P2A969cx2Zp4OgxBT7T050m96tb0PAP6+Dp89jaYs2vw4lMrmEOTzODXFi4XZq4q27JbpHXad+/fk5nLWCaMEWL/0PCFOUyrSXXANaKBN71BtFNEeiLVh/IeDyZdQ+1IEoXObbfIn6XU/C7H7loFTMUN+TM+K2+POppjpNnBSIVWX5HrBJDCgHQ8zO4Q8gXh2ERcI/Ss5F+z97fjiFxG53hjhbSlWNLWAUw6kqcY4h7KtuvhII9nAFJHRRy3XbY+48TqLyQZ3GxqhzTUGoinl3z+7AHZfmcjg0lcOynX6o+fdS+xoZePHa0320+8GmqkGWq/pnhiwdLQ/9pZBBofAfa0jDRjXe1rCPoNChurrNAsNlPyjbqFCYOGuDG8Q== ${EMAIL}" >> ${USER_HOME}/.ssh/authorized_keys
}


function setup_bin_files {
    echo "Setup bin files.."
    cp -r bin ${USER_HOME}/
}


#######################



###  MAIN FUNCTIONS ###

function personal_setup {

  echo "install app packages.."
    apt-get update
    apt-get -y install curl wget sudo zsh neovim vim-gtk3 tmux git gitk htop nmap ack-grep \
                    pnmixer diodon xsel scrot udiskie xdotool wmctrl openjdk-21-jdk
                   

  setup_zsh 
  setup_configs "local"
  setup_git ${USER_NAME}
  setup_bin_files
}



function server_setup {

  echo "Installing Debian packages.."
  apt-get update
  apt-get -y install zsh vim git ssh wget htop nmap sudo curl unzip ack-grep


  setup_configs "server"
  setup_zsh
  setup_git ${HOSTNAME}
  setup_hostname
  setup_ssh

}


#######################




###    MAIN PROGRAM   ###

if [[ ${1} == "local" ]]; then
  personal_setup
  exit 0

elif [[ ${1} == "server" ]]; then
  server_setup
  exit 0
  
else
    echo "ERROR: You need run command as:"
    echo "${0} server <hostname>   -- for installation on server"
    echo "${0} local               -- for installation on my personal computer"
    exit 1
fi

exit 0

#########################

