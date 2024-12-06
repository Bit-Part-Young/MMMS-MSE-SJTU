#!/bin/bash

# 检查是否安装 git 以安装 MMMS 课程上机实验材料

repo_url=https://gitee.com/sjtu_konglt/MSE6701H.git

mmms_path="${HOME}/MSE6701H"

printf "%`tput cols`s" | tr ' ' '-'

echo
echo "MMMS Course Materials:"
echo

if [ -x "$(command -v git)" ]; then
    if [[ ! -d ${mmms_path} ]]; then

        echo "Starting to download..."
        echo

        git clone ${repo_url}

        echo
        echo "Downloaded to ${mmms_path}."
        echo

        cd - > /dev/null
    elif [[ -d ${mmms_path} ]]; then
        echo "Already downloaded to ${mmms_path}. Not need to git clone again!"
        echo
    fi

else
    echo 'Error: Make sure git is installed!' >&2
    exit 1
fi

printf "%`tput cols`s" | tr ' ' '-'
