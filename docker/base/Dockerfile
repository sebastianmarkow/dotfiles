FROM ubuntu:zesty
MAINTAINER Sebastian Klatt <sebastian@markow.io>

ENV DEV_USER dev
ENV DEV_TMUX_VERSION 2.5

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TERM xterm-256color

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common python-software-properties && \
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        curl \
        fish \
        gcc \
        git \
        libevent-dev \
        libncurses-dev \
        locales \
        make \
        man-db \
        neovim \
        python \
        python-dev \
        python-pip \
        python3 \
        python3-dev \
        python3-pip \
        ssh \
        sudo \
        wget \
        xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget -O tmux.tar.gz https://github.com/tmux/tmux/releases/download/${DEV_TMUX_VERSION}/tmux-${DEV_TMUX_VERSION}.tar.gz && \
    tar xzf tmux.tar.gz && \
    cd tmux-${DEV_TMUX_VERSION}/ && \
    ./configure && \
    make && \
    make install && \
    cd && \
    rm -rf /tmp/src

RUN pip3 install --upgrade --no-cache-dir pip setuptools wheel && \
    pip3 install --upgrade --no-cache-dir neovim

RUN useradd -ms /usr/bin/fish ${DEV_USER} && \
    usermod -aG sudo ${DEV_USER} && \
    passwd -d ${DEV_USER}

USER ${DEV_USER}
WORKDIR /home/${DEV_USER}

RUN git clone https://github.com/sebastianmarkow/dotfiles.git .dotfiles && \
    cd .dotfiles && \
    make dotfiles

RUN fish -c "fish_update_completions"

CMD fish -c "tmux"
