FROM debian:bookworm-slim

ENV NONINTERACTIVE=true

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        git \
        python3 \
        python3-dev \
        python3-pip \
        vim \
        openssh-client \
        curl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

WORKDIR /app

COPY pyproject.toml .
COPY src .
RUN uv sync --locked

COPY . .

CMD ["bash"]