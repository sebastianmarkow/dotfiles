#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

FORMULAS=(
    act
    argo
    argocd
    datawire/blackbird/telepresence
    derailed/k9s/k9s
    derailed/popeye/popeye
    wagoodman/brew/dive # TUI Docker image layer explorer
    fluxcd/tap/flux
    hadolint
    helm
    istioctl
    jesseduffield/lazydocker/lazydocker # TUI for Docker (companion to lazygit)
    kind
    krew
    kubecolor   # colorizes kubectl output (drop-in replacement)
    kubeconform
    kubectx
    kubeseal
    kustomize
    stern
    termshark # TUI frontend for tshark/Wireshark packet analysis
    terraform
    terraform-docs
    terragrunt
    tflint
    trivy # IaC + container + secrets scanner (replaces tfsec; tfsec merged into trivy)
)

CASKS=(
    homebrew/cask/google-cloud-sdk
)

KREW=(
    access-matrix
    deprecations
    get-all
    kubesec-scan
    lineage
    neat
    sniff
    sort-manifests
    trace
    tree
    who-can
)

h1 "devops"
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h1 "kubectl krew"
task "update"
kubectl krew update > /dev/null 2>&1
if [[ $? != 0 ]]; then
    error
    exit 1
else
    success
fi
h2 "kubectl krew plugins"
for f in "${KREW[@]}"; do krew_install "$f"; done
