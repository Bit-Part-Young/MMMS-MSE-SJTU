#!/bin/bash


# 配置 ~/.vimrc
#-------------------------------------------------------------------------------
echo -e "Vim config file is starting to download...\n"

vim_file=$HOME/.vimrc
file_url=https://gitee.com/yangsl306/MMMS-scripts/raw/main/shell-scripts
if [ -f ${vim_file} ]; then
    cp ${vim_file}{,.bak}
fi

wget ${file_url}/$(basename ${vim_file}) -O ${vim_file}

echo -e "\nVim config file has been downloaded to ${vim_file}.\n"
echo -e "\n#-------------------------------------------------------------------------------#\n\n"
#-------------------------------------------------------------------------------


# 配置 ~/.bashrc
#-------------------------------------------------------------------------------
echo -e "Bash config file is starting to download...\n"

bashrc_file=$HOME/.bashrc
if [ -f ${bashrc_file} ]; then
    cp ${bashrc_file}{,.bak}
fi

wget ${file_url}/$(basename ${bashrc_file}) -O ${bashrc_file}

echo -e "\nBash config file has been downloaded to ${bashrc_file}.\n"
echo -e "\n#-------------------------------------------------------------------------------#\n\n"
#-------------------------------------------------------------------------------


# 配置 ~/.inputrc
#-------------------------------------------------------------------------------
echo -e "Readline config file is starting to download...\n"

inputrc_file=$HOME/.inputrc
if [ -f ${inputrc_file} ]; then
    cp ${inputrc_file}{,.bak}
fi

wget ${file_url}/$(basename ${inputrc_file}) -O ${inputrc_file}

echo -e "\nReadline config file has been downloaded to ${inputrc_file}.\n"
echo -e "\n#-------------------------------------------------------------------------------#\n\n"
#-------------------------------------------------------------------------------


# 检查是否安装 git 以安装 MMMS 课程上机实验材料
#-------------------------------------------------------------------------------
repo_url=https://gitee.com/yangsl306/MMMS.git
# repo_url=https://gitee.com/sjtu_konglt/MMMS.git
parent_path=$HOME/MSE6701H

if [ -x "$(command -v git)" ]; then
    if [ ! -d ${parent_path} ]; then
        mkdir ${parent_path}

        cd ${parent_path}

        echo -e "MMMS Course Materials are starting to download...\n"
        git clone $repo_url

        echo -e "\nMMMS Course Materials have been downloaded to ${parent_path}.\n"

        cd - > /dev/null
    else
        echo -e "MMMS course materials have been downloaded to ${parent_path}.\n"
    fi

else
    echo 'Error: git is not installed.' >&2
    exit 1
fi

echo -e "\n#-------------------------------------------------------------------------------#\n\n"
#-------------------------------------------------------------------------------


: '
# 创建 ~/bin 目录； 拷贝 atomsk vasp_std vaspkit 可执行程序到 ~/bin 目录
echo -e "MD & DFT related binary files are starting to copy to ~/bin path...\n"

bin_path=$HOME/bin
#-------------------------------------------------------------------------------
if [ ! -d ${bin_path} ]; then
    mkdir ${bin_path}
fi

md_tools_path=$HOME/MSE6701H/MMMS/2-MolecularDynamics/0-tools
dft_tools_path=$HOME/MSE6701H/MMMS/3-DFT/0-tools

cp ${md_tools_path}/atomsk ${bin_path}
cp ${dft_tools_path}/vaspkit ${bin_path}
cp ${dft_tools_path}/vasp_std ${bin_path}

echo -e "\nMD & DFT related binary files have been copied to ~/bin path...\n"
echo -e "\n#-------------------------------------------------------------------------------#\n\n"
#-------------------------------------------------------------------------------
'
