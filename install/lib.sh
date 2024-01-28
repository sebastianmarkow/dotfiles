#!/usr/bin/env bash

ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function section() {
    length=${#1}
    printf "%s\n" "$1"
    printf '%*s\n' "$length" | tr ' ' "$2"
}

function h1() {
    printf "\n"
    section "$1" "="
}

function h2() {
    printf "\n"
    section "$1" "-"
}

function task() {
    printf "* %-50s" "$1"
}

function success() {
    if [ -n "$1" ]; then
        printf "%b[%s]%b\n" "$COL_GREEN" "$1" "$COL_RESET"
    else
        printf "%b[success]%b\n" "$COL_GREEN" "$COL_RESET"
    fi
}

function error() {
    printf "%b[error] %s%b\n" "$COL_RED" "$1" "$COL_RESET"
}

function warn() {
    printf "%b[%s]%b\n" "$COL_YELLOW" "$1" "$COL_RESET"
}

function brew_tap() {
    INSTALLED_TAPS=${INSTALLED_TAPS:-"$(brew tap | tr A-Z a-z)"}
    task "tap $1"
    echo "$INSTALLED_TAPS" | grep "$1" > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[1]} != 0 ]]; then
        brew tap "$1" > /dev/null 2>&1
        if [[ $? != 0 ]]; then
            error
        else
            success
        fi
    else
        warn "tapped"
    fi
}

function brew_install() {
    INSTALLED_FORMULAS=${INSTALLED_FORMULAS:-"$(brew list --full-name --formula | tr A-Z a-z)"}
    task "install $1"
    echo "$INSTALLED_FORMULAS" | grep "$1" > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[1]} != 0 ]]; then
        brew install $1 $2 > /dev/null 2>&1
        if [[ $? != 0 ]]; then
            error
        else
            success
        fi
    else
        warn "installed"
    fi
}

function cask_install() {
    INSTALLED_CASKS=${INSTALLED_CASKS:-"$(brew list --full-name --casks -1 | tr A-Z a-z)"}
    task "install $1"
    echo "$INSTALLED_CASKS" | grep "$1" > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[1]} != 0 ]]; then
        brew install $1 $2 > /dev/null 2>&1
        if [[ $? != 0 ]]; then
            error
        else
            success
        fi
    else
        warn "installed"
    fi
}

function pip_install() {
    INSTALLED_MODULES=${INSTALLED_MODULES:-"$(pip3 list --format freeze | cut -f 1 -d "=" | tr A-Z a-z)"}
    task "install $1"
    unset PIP_REQUIRE_VIRTUALENV
    echo "$INSTALLED_MODULES"| grep "$1" > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[1]} != 0 ]]; then
        pip3 install -qqq "$1" > /dev/null 2>&1
        if [[ $? != 0 ]]; then
            error
        else
            success
        fi
    else
        warn "installed"
    fi
}

function gem_install() {
    INSTALLED_GEMS=${INSTALLED_GEMS:-"$(gem list -q | cut -f 1 -d " " | tr A-Z a-z)"}
    task "install $1"
    echo "$INSTALLED_GEMS"| grep "$1" > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[1]} != 0 ]]; then
        gem install -q --silent "$1" > /dev/null 2>&1
        if [[ $? != 0 ]]; then
            error
        else
            success
        fi
    else
        warn "installed"
    fi
}

function go_get() {
    task "install $1"
    go install "$1" > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        error
    else
        success
    fi
}

function cargo_install() {
    INSTALLED_CRATES=${INSTALLED_CRATES:-"$(cargo install --list | tr A-Z a-z)"}
    task "install $1"
    echo "$INSTALLED_CRATES" | grep "$1" > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[1]} != 0 ]]; then
        cargo install --quiet "$1" > /dev/null 2>&1
        if [[ $? != 0 ]]; then
            error
        else
            success
        fi
    else
        warn "installed"
    fi
}

function pyenv_install() {
    INSTALLED_ENVS=${INSTALLED_ENVS:-"$(pyenv versions --bare)"}
    task "install $1"
    echo "$INSTALLED_ENVS" | grep "$1" > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[1]} != 0 ]]; then
        pyenv install --skip-existing "$1" > /dev/null 2>&1
        if [[ $? != 0 ]]; then
            error
        else
            success
        fi
    else
        warn "installed"
    fi
}

function krew_install() {
    task "install $1"
    kubectl krew install "$1" > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        error
    else
        success
    fi
}

function execute() {
    task "execute $1"
    echo "$0 $@"
    $1 > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        error
    else
        success
    fi
}
