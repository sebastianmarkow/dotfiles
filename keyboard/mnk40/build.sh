#!/usr/bin/env bash

QMK_DIR="$(ghq list --full-path qmk_firmware)"

if [ ! -d "$QMK_DIR" ]; then
    echo "error: qmk_firmware is not available." >&2
    exit 1
fi

cp -r ./ "${QMK_DIR}/keyboards/mnk40"

pushd "${QMK_DIR}" || exit

./util/docker_build.sh mnk40:default

popd || exit
