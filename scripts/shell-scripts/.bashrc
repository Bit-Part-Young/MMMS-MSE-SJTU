# siyuan default configuration
######################################################################
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

if [ ! -f ~/.ssh/id_rsa ]; then
    echo 'No public/private RSA keypair found.'
    ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    echo "StrictHostKeyChecking no" > ~/.ssh/config
    chmod 600 ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/config
fi

######################################################################



# alias
######################################################################

alias ll='ls -hlF'
alias la='ls -hlAF'
alias l='ls -CF'


alias LS="ls"
alias bk="cd ..; ls"
alias ..="cd ../..; ls"

# slurm related
alias clo="rm -rf *.out *.err"
alias q="squeue"

######################################################################



# PATH
######################################################################

export PATH=$PATH:$HOME/bin
# 课程材料用 DFT MD 部分可执行程序 如 vasp_std vaspkit atomsk eos_fit 等
export PATH=$PATH:$HOME/MSE6701H/MMMS/2-MolecularDynamics/0-tools
export PATH=$PATH:$HOME/MSE6701H/MMMS/3-DFT/0-tools


######################################################################

