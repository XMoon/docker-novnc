# docker-novnc

[![Docker Pulls](https://img.shields.io/docker/pulls/oott123/novnc.svg)](https://hub.docker.com/r/oott123/novnc/) [![Docker Automated build](https://img.shields.io/docker/automated/oott123/novnc.svg)](https://hub.docker.com/r/oott123/novnc/)

tigervnc, websokify, novnc and Nginx with s6-overlay in a docker image.

## Environment variables

* **`VNC_GEOMETRY`** - VNC geometry; default: `800x600`
* **`VNC_PASSWD`** - VNC password, no more than 8 chars; default: `MAX8char`
* **`USER_PASSWD`** - user `user` password. If you specify it, it will change the password for user `user` and add it to sudoers. NOTE: This password can get by programs so it's not safe. default: _(blank)_

## Ports

* **5901** - tigervnc
* **9000** - Nginx
* **9001** - websockify
