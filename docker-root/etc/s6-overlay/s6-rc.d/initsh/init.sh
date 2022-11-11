#!/command/with-contenv bash

set -eo pipefail

[[ $DEBUG == true ]] && set -x

echo -e "$VNC_PASSWD\n$VNC_PASSWD\n\n" | sudo -Hu user vncpasswd
if [ ! -d /etc/vnc ]; then
    mkdir /etc/vnc
fi
echo 'openbox-session' > /etc/vnc/xstartup

# Clear X lock.
# Some container host (e.g. hyper.sh) will keep /tmp even after a restart.
if [ -f /tmp/.X11-lock ]; then
    rm -f /tmp/.X11-lock
fi

if [ "$USER_PASSWD" != '' ]; then
    # set user password
    echo "user:$USER_PASSWD" | chpasswd
    # and give sudo power to user
    echo '' >> /etc/sudoers
    echo 'user  ALL=(ALL:ALL) ALL' >> /etc/sudoers
fi