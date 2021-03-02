#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

FORMULAS=(
    act
    awscli
    circleci
    derailed/k9s/k9s
    derailed/popeye/popeye
    fluxcd/tap/flux
    hadolint
    helm
    istioctl
    kind
    krew
    kubectx
    kubeseal
    kustomize
    skaffold
    stern
    terraform
    terraform-docs
    tflint
    tfsec
    vault
)

CASKS=(
    homebrew/cask/docker
    homebrew/cask/google-cloud-sdk
    homebrew/cask/lens
)

h1 "devops"
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
