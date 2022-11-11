FROM ubuntu:22.04

# 各种环境变量
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    VNC_GEOMETRY=800x600 \
    VNC_PASSWD=MAX8char \
    USER_PASSWD='' 

ARG DEBIAN_FRONTEND=noninteractive

# 首先加用户，防止 uid/gid 不稳定
RUN groupadd user && useradd -m -g user user

# 安装系统基础依赖
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y \
        git xz-utils \
        ca-certificates wget curl locales \
        nginx sudo python3-numpy \
        xorg openbox rxvt-unicode && \
    locale-gen en_US.UTF-8 && \
    apt-get autoremove -y &&\
    apt-get clean && rm -rf /var/lib/apt/lists

# tigervnc
RUN apt-get update -y && \
    apt-get install -y tigervnc-common tigervnc-standalone-server && \
    apt-get install -y xdg-utils wmctrl --fix-missing && \
    apt-get autoremove -y &&\
    apt-get clean && rm -rf /var/lib/apt/lists

# s6-overlay
RUN wget -O /tmp/s6-overlay-noarch.tar.xz https://github.com/just-containers/s6-overlay/releases/download/v3.1.2.1/s6-overlay-noarch.tar.xz && \
    tar -C / -xvJf /tmp/s6-overlay-noarch.tar.xz && \
    wget -O /tmp/s6-overlay-x86_64.tar.xz https://github.com/just-containers/s6-overlay/releases/download/v3.1.2.1/s6-overlay-x86_64.tar.xz && \
    tar -C / -xvJf /tmp/s6-overlay-x86_64.tar.xz && \
    rm /tmp/s6-overlay-noarch.tar.xz /tmp/s6-overlay-x86_64.tar.xz


# novnc
RUN mkdir -p /app/src && \
    git clone --depth=1 https://github.com/novnc/noVNC.git /app/src/novnc && \
    git clone --depth=1 https://github.com/novnc/websockify.git /app/src/websockify && \
    rm -fr /app/src/novnc/.git /app/src/websockify/.git

# copy files
COPY ./docker-root /

EXPOSE 9000/tcp 9001/tcp 5901/tcp

# don't edit this
ENV DISPLAY=:11 \
    VNC_PASSWORD=''

ENTRYPOINT [ "/init"]