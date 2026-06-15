#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/lib.sh"

# Homebrew formulas and casks live in install/Brewfile.devops.

KREW=(
    access-matrix    # access-matrix - show RBAC access matrix
    deprecations     # deprecations - find deprecated API usage
    get-all          # get-all - list all resources in namespace
    kubesec-scan     # kubesec-scan - security risk analysis
    lineage          # lineage - show owner references chain
    neat             # neat - print clean resource manifests
    sniff            # sniff - packet capture in pods
    sort-manifests   # sort-manifests - sort YAML manifests
    trace            # trace - trace syscalls in pod
    tree             # tree - show resource ownership tree
    who-can          # who-can - show who can perform RBAC actions
)

h1 "devops"
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
