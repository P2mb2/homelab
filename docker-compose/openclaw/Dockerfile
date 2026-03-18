FROM ghcr.io/openclaw/openclaw:latest

USER root

# Install Python and basic dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    wget \
    unzip \
    git \
    build-essential \
    nano \
    vim \
    zsh \
    openssh-server \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Bun (required for QMD)
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH=$PATH:/root/.bun/bin

# Install QMD (local-first memory search backend for OpenClaw)
RUN bun install -g https://github.com/tobi/qmd
RUN ln -sf /root/.bun/bin/qmd /usr/local/bin/qmd

# Configure SSH
RUN mkdir -p /var/run/sshd /root/.ssh && \
    chmod 700 /root/.ssh && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A

#Harcoded public key for nabuopenclaw
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN8aa/k9UGeP3cWwIlJaHs2NzDk+Erf4GqJKDJp/1knS nabuopenclaw" > /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys

# Entrypoint: starts sshd then runs original container command
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set zsh as the default shell for root
RUN chsh -s /usr/bin/zsh root

# Install Go
# Fetch the latest Go version or a specific one (e.g., 1.22)
ENV GO_VERSION=1.26.1
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# Install gogcli (Google Workspace CLI by steipete)
# https://github.com/steipete/gogcli
ENV GOGCLI_VERSION=0.12.0
RUN mkdir -p /tmp/gogcli_ext && \
    wget -q "https://github.com/steipete/gogcli/releases/download/v${GOGCLI_VERSION}/gogcli_${GOGCLI_VERSION}_linux_amd64.tar.gz" -O /tmp/gogcli.tar.gz && \
    tar -xzf /tmp/gogcli.tar.gz -C /tmp/gogcli_ext/ && \
    find /tmp/gogcli_ext -type f -perm /111 -exec install -m 755 {} /usr/local/bin/gogcli \; && \
    rm -rf /tmp/gogcli.tar.gz /tmp/gogcli_ext

CMD ["node","openclaw.mjs","gateway","--allow-unconfigured"]
ENTRYPOINT ["/entrypoint.sh"]
