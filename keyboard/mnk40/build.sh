#!/usr/bin/env bash

QMK_DIR="$(ghq list --full-path qmk_firmware)"

if [ ! -d "$QMK_DIR" ]; then
    echo "error: qmk_firmware is not available." >&2
    exit 1
fi

rm -r "${QMK_DIR}/keyboards/mnk40"
cp -r ./ "${QMK_DIR}/keyboards/mnk40"

pushd "${QMK_DIR}" || exit

qmk compile --keyboard mnk40 --keymap sebastianmarkow

popd || exit
