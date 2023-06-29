# test

Some messy little scripts

[TOC]



------

## create_Docker_Registry

A script for creating a Docker Registry through Docker. Contains setting username and password for Docker Registry.

1. Enter YOUR_ USERNAME and YOUR_ PASSWORD in createRegistry.sh.

2. Set permissions for scripts:

```
chmod 755 createRegistry.sh
```

3. execute shell:

   ```
   cat createRegistry.sh | bash
   ```

   

------

## findImage

findImage.sh is used to iterate through the helm chart and yaml files to find the declared image used by the file.



------

## getGitCode

getGitCode is used to pull code from the specified git repository. The project name needs to be defined in projects.txt, and the git user needs to be set using YOUR_ USERNAME and YOUR_ PASSWORD.



------

## uninstall_Kubernetes

Uninstall_ Kubernetes is used to delete K8s nodes. First, configure the inventoryini file, and then execute ./uninstall.sh
