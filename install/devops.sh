#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    derailed/k9s
)

FORMULAS=(
    awscli
    circleci
    derailed/k9s/k9s
    helm
    k3d
    kind
    kubectx
    kubernetes-cli
    terraform
    vault
)

CASKS=(
    docker
    google-cloud-sdk
    vagrant
)

h1 "devops"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
