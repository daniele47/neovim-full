#!/bin/bash

set -e

UNSAFE_DIRS=(
    "$HOME"
    "$HOME/.config"
    "$HOME/.local"
    "$HOME/.local/share"
    "$HOME/.local/state"
    "$HOME/.var"
    "$HOME/.var/app"
)
DIR_PATH="$(realpath "$1")"

# checks on string to mount
if [ ! -d "$DIR_PATH" ] || [ ! -w "$DIR_PATH" ] || [ ! -O "$DIR_PATH" ]; then
    echo "invalid directory: '$DIR_PATH'"
    exit 1
fi
for UNSAFE_DIR in "${UNSAFE_DIRS[@]}"; do 
    [[ "$DIR_PATH" == "$UNSAFE_DIR" ]] && echo "'$UNSAFE_DIR' is an unsafe directory to mount!" && exit 1
done

podman run -it --rm \
    --init \
    -e "TZ=$(timedatectl show --property=Timezone --value)" \
    --detach-keys="" \
    --security-opt label=type:container_runtime_t \
    -v "$DIR_PATH":/data \
    -w /data \
    ghcr.io/daniele47/neovim bash
