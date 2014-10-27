GAPI
====

Graph API Docker container with installer.

Prerequisities
==============

These have to be installed:

  * *bash*, *awk*, *sed* - used in installation script and helper scripts
  * *git* - for cloning repositories and development
  * *docker* - container platform

Installation
============

```
curl -sSL https://raw.githubusercontent.com/pirati-cz/gapi/master/install.sh | bash -s /dir-to-install-graph
```
 
Running
=======

In core directory are four bash scripts:

  * *build_image.sh* - build docker piraticz/gapi image
  * *gapi.sh* - you can start, stop, restart or check status about GAPI docker image
 
  Documentation
=============

Internal documentation is [here](docs/internal.md).
