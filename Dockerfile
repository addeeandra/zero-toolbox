# ============================================================
# zeroclaw-toolbox
# Debian base with zeroclaw + tools for multi-modal AI agents
# ============================================================
FROM ghcr.io/zeroclaw-labs/zeroclaw:beta-debian

# -- Use root to install additional tools ─────────────────────
USER root

# ── Build args ───────────────────────────────────────────────
ARG DEBIAN_FRONTEND=noninteractive

# ── Additional system tools ──────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Core utilities
    curl \
    wget \
    git \
    lsb-release \
    # Shell & text tools
    jq \
    yq \
    ripgrep \
    fd-find \
    tree \
    less \
    unzip \
    wget \
    # Process & system monitoring
    htop \
    procps \
    lsof \
    # Networking
    dnsutils \
    openssh-client \
    # Python 3.12 + pip
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    # Image & document processing
    ffmpeg \
    imagemagick \
    # Misc
    tzdata \
    locales \
    && rm -rf /var/lib/apt/lists/*

# ── Locale ───────────────────────────────────────────────────
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# ── Node.js LTS (includes npm + npx) ─────────────────────────
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# ── GitHub CLI (gh) ───────────────────────────────────────────
RUN install -d -m 755 /etc/apt/keyrings \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# ── Python AI/ML packages ─────────────────────────────────────
RUN pip3 install --no-cache-dir --break-system-packages \
    # Document processing
    'pypdf==6.9.1' \
    'python-docx==1.2.0' \
    'openpyxl==3.1.5' \
    'markdown==3.10.2' \
    'beautifulsoup4==4.14.3' \
    'lxml==6.0.2' \
    # Web scraping
    'playwright==1.58.0'

# ── Playwright browsers (for web agent capabilities) ──────────
RUN python3 -m playwright install chromium --with-deps || true

USER 65534:65534
WORKDIR /zeroclaw-data
