FROM fedora:latest 
LABEL maintainer="Preston Davis pdavis@pebcac.org"
# Package install
RUN sudo dnf update -y && dnf install -y \
    curl \
    git \
    htop \
    jq \
    net-tools \
    procps-ng \
    vim \
    wget \
    zsh && \
    sudo dnf clean all
# Add default user
RUN useradd pdavis -u 1000 -G wheel
# User to execute the remaining commands
USER pdavis
# Enable terminal colors
ENV TERM xterm
# user home dir
ENV HOME=/home/pdavis
# Set working directory
WORKDIR $HOME
# Install cheat.sh
RUN mkdir -p $HOME/bin/ && \
    curl https://cht.sh/:cht.sh > $HOME/bin/cht.sh && \
    chmod +x $HOME/bin/cht.sh
# Include $HOME/bin in path
ENV PATH=$PATH:$HOME/bin
# Install SpaceVIM
RUN curl -sLf https://spacevim.org/install.sh | bash
# Install oh-my-zsh
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
# set the zsh theme
ENV ZSH_THEME=robbyrussell
# set default terminal to zsh
CMD ["zsh"]
