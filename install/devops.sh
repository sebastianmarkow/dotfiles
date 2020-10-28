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
    dive
    helm
    k3d
    kind
    krew
    kubectx
    kubernetes-cli
    skaffold
    stern
    terraform
    tflint
    vault
)

CASKS=(
    docker
    google-cloud-sdk
    lens
)

HELM_PLUGINS=(
    "helm plugin install https://github.com/instrumenta/helm-kubeval"
)

h1 "devops"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "helm plugins"
for f in "${HELM_PLUGINS[@]}"; do execute "$f"; done
