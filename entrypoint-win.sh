#!/bin/bash

Xvfb :0 -screen 0 800x600x16 &

# use something like this if it fails
# xinit "$DATA_DIR" -- /usr/bin/Xvfb :0 -screen 0 800x600x16 -ac &

export DISPLAY=:0.0
exec /bin/bash "$@"
