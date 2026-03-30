#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    buo/cask-upgrade
)

FORMULAS=(
    atuin        # Atuin - shell history with full-text search and stats
    bash         # GNU Bash - shell
    bob          # bob - Neovim version manager
    btop         # btop++ - resource monitor
    colima       # Colima - container runtime for macOS
    coreutils    # GNU Core Utilities - basic file/shell utilities
    curl         # cURL - HTTP client
    delta        # git-delta - syntax-highlighted diff pager
    diffutils    # GNU Diffutils - file comparison
    direnv       # direnv - per-directory environment variables
    duf          # DUF - disk usage/free (df replacement)
    dust         # dust - disk usage tree (du replacement)
    docker       # Docker - container engine
    fd           # fd - fast find replacement
    findutils    # GNU Findutils - find/xargs/locate
    fish         # Fish - interactive shell
    fzf          # fzf - fuzzy finder
    gawk         # GNU Awk - text processing
    gh           # GitHub CLI - GitHub from terminal
    ghq          # ghq - repository manager
    git          # Git - version control
    git-crypt    # git-crypt - transparent git encryption
    git-extras   # git-extras - additional git commands
    git-lfs      # Git LFS - large file storage
    gnu-sed      # GNU sed - stream editor
    gnu-tar      # GNU tar - archiver
    gnupg        # GnuPG - encryption and signing
    grep         # GNU grep - pattern matching
    bandwhich    # Bandwhich - network utilization by process
    grpcurl      # gRPCurl - gRPC client
    jq           # jq - JSON processor
    lazygit      # Lazygit - TUI git client
    less         # less - file pager
    make         # GNU Make - build automation
    massren      # massren - bulk file rename via editor
    moreutils    # moreutils - additional Unix utilities
    navi         # navi - interactive cheatsheet with fzf
    mtr          # mtr - network diagnostics (ping + traceroute)
    neovim       # Neovim - text editor
    nmap         # Nmap - network scanner
    nvtop        # nvtop - GPU monitor
    pidof        # pidof - find process ID by name
    pipx         # pipx - install and run Python applications in isolated environments
    pstree       # pstree - process tree viewer
    procs        # procs - process viewer (ps replacement)
    rename       # rename - batch file renamer
    ripgrep      # ripgrep - fast grep replacement
    rsync        # rsync - file sync and transfer
    since        # since - show new file content since last check
    ssh-copy-id  # ssh-copy-id - install SSH public keys
    starship     # Starship - cross-shell prompt
    tcpdump      # tcpdump - network packet analyzer
    tmux         # tmux - terminal multiplexer
    tree         # tree - directory tree viewer
    watch        # watch - run command periodically
    viddy        # Viddy - watch replacement with diff highlighting
    oha          # oha - HTTP load tester with TUI
    wget         # Wget - file downloader
    xo/xo/usql  # usql - universal SQL client
    xz           # XZ Utils - compression
    yazi         # Yazi - TUI file manager
    yq           # yq - YAML/JSON/TOML processor
    yt-dlp       # yt-dlp - video downloader
    zk           # zk - plain-text note-taking with Zettelkasten
    zoxide       # zoxide - smarter cd command
)

CASKS=(
    1password-cli                  # 1Password CLI - password manager CLI
    font-jetbrains-mono-nerd-font  # JetBrains Mono Nerd Font - coding font with icons
    hammerspoon                    # Hammerspoon - macOS automation
    kitty                          # Kitty - GPU-accelerated terminal
)

h1 "minimal"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "brew formulas (HEAD)"
for h in "${HEAD[@]}"; do brew_install "$h" "--HEAD"; done
