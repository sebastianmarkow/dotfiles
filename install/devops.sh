#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

FORMULAS=(
    act                                    # act - run GitHub Actions locally
    argo                                   # Argo Workflows - Kubernetes workflow engine
    argocd                                 # Argo CD - GitOps continuous delivery
    datawire/blackbird/telepresence        # Telepresence - local-to-cluster dev proxy
    derailed/k9s/k9s                       # K9s - TUI Kubernetes cluster manager
    derailed/popeye/popeye                 # Popeye - Kubernetes resource sanitizer
    wagoodman/brew/dive                    # Dive - Docker image layer explorer
    fluxcd/tap/flux                        # Flux - GitOps toolkit for Kubernetes
    hadolint                               # Hadolint - Dockerfile linter
    helm                                   # Helm - Kubernetes package manager
    istioctl                               # Istioctl - Istio service mesh CLI
    jesseduffield/lazydocker/lazydocker    # Lazydocker - TUI Docker manager
    kind                                   # kind - Kubernetes in Docker
    krew                                   # krew - kubectl plugin manager
    kubecolor                              # kubecolor - colorized kubectl output
    kubeconform                            # kubeconform - Kubernetes manifest validator
    kubectx                                # kubectx - Kubernetes context/namespace switcher
    kubeseal                               # kubeseal - Kubernetes secret encryption
    kustomize                              # Kustomize - Kubernetes config customizer
    stern                                  # Stern - multi-pod log tailer
    termshark                              # Termshark - TUI packet analyzer
    terraform                              # Terraform - infrastructure as code
    terraform-docs                         # terraform-docs - generate Terraform documentation
    terragrunt                             # Terragrunt - Terraform wrapper
    tflint                                 # TFLint - Terraform linter
    trivy                                  # Trivy - IaC/container/secrets security scanner
)

CASKS=(
    homebrew/cask/google-cloud-sdk  # Google Cloud SDK - GCP CLI tools
)

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
