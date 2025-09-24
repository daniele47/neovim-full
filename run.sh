#!/bin/bash

podman run -it --rm \
    --init \
    -e "TZ=$(timedatectl show --property=Timezone --value)" \
    --detach-keys="" \
    -v neovim-data:/data \
    -w /data \
    ghcr.io/daniele47/neovim bash
