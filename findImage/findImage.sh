#!/bin/bash

# 设置目标文件夹的路径
dir=/root

# 遍历所有 YAML 和 Helm Chart 文件
find $dir -type f \( -name '*.yaml' -o -name '*.yml' -o -name '*.chart' -o -name '*.tgz' \) | while read file; do
  # 提取文件中所有镜像名、标签和版本信息
  #echo $file
  #images=$(grep -Eo '([a-zA-Z0-9\-./_:]+)?docker.io/([a-zA-Z0-9\-._/]+)?[:@][a-zA-Z0-9\-.]+' $file)
  #images=$(grep -Eo '([a-zA-Z0-9\-./_:]+)?docker\.io/([a-zA-Z0-9\-._/]+)?[:@][a-zA-Z0-9\-.]+' $file)
  
  # 将每个镜像名、标签和版本信息分别写入目标文件中
  while read -r image; do
     cat /root/compass-deck-deployment/charts/compass-deck/templates/canvas.yaml | awk '/^ *image: */ { in_image=1; registry=""; repository=""; tag=""; } \
    /^ *registry: */ { registry=$2 } \
    /^ *repository: */ { repository=$2 } \
    /^ *tag: */ { tag=$2; if(in_image && repository!="") { if(registry!="") printf("%s/", registry); printf("%s:%s\n", repository, tag); } in_image=0;} \
    END { if(in_image && repository!="") { if(registry!="") printf("%s/", registry); printf("%s:%s\n", repository, tag); } }' | uniq >  $dir/images.txt
  done 
done

