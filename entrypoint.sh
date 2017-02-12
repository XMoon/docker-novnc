#!/usr/bin/with-contenv /bin/bash
set -eo pipefail

[[ $DEBUG == true ]] && set -x

export VNC_PASSWORD=''
export DISPLAY=:1

case ${1} in
  help)
    echo "No help!"
    ;;
  start)
    /bin/s6-svc -wu -T 5000 -u /var/run/s6/services/websocketify
    /bin/s6-svc -wu -T 5000 -u /var/run/s6/services/nginx
    sudo --preserve-env -u user /app/vncmain.sh "$@"
    ;;
  *)
    exec "$@"
    ;;
esac

exit 0