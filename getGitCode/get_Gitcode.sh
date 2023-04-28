#!/bin/bash

YOUR_USERNAME=
YOUR_PASSWORD=

# 从txt文件中读取项目名和tag
while read line; do
  echo "${line} processing..."
  # 忽略注释和空行
  if [[ ! $line =~ ^\# && $line != "" ]]; then
    name=${line%:*}
    version=${line#*:}
    echo "Cloning $name:$version"
    # 使用git clone命令拉取代码
    git clone --branch $version https://$YOUR_USERNAME:$YOUR_PASSWORD@git.dameng.com/dmcca/$name.git
  fi
done < projects.txt