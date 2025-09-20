FROM fedora

# install needed packages
RUN dnf install -y --setopt=install_weak_deps=False lsd ripgrep bat bash-completion htop bat jq zoxide fzf \
    iproute iputils bind-utils neovim git unzip wget ripgrep tree-sitter-cli nodejs npm python3 gcc && \
    dnf autoremove -y && dnf clean all 

# initialize neovim and bash
COPY ./nvim /root/.config/nvim
COPY ./bashrc /root/.bashrc
COPY ./gitconfig /root/.gitconfig
RUN nvim --headless +StarterPack +qa && rm -rf /root/.cache /root/.npm
