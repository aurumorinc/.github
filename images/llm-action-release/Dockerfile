FROM python:3.14-slim

ARG ACTION_REF=v1.4.0

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH=/action/src

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    jq \
    curl \
    ca-certificates \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /action

# Fetch source code directly from upstream release tag at build time
RUN git clone --depth 1 --branch ${ACTION_REF} https://github.com/nosovj/llm-release-action.git /tmp/llm-release-action \
    && pip install --no-cache-dir -r /tmp/llm-release-action/src/requirements.txt \
    && cp -r /tmp/llm-release-action/src /action/src \
    && rm -rf /tmp/llm-release-action

COPY images/llm-action-release/entrypoint.sh /action/entrypoint.sh
RUN chmod +x /action/entrypoint.sh

ENTRYPOINT ["/action/entrypoint.sh"]
