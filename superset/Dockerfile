FROM ghcr.io/astral-sh/uv:python3.11-bookworm

# RUN apk add --no-cache build-base

WORKDIR /app
RUN mkdir -p /app/superset-init-lock

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project

RUN useradd -m superset
RUN chown -R superset:superset /app
USER superset

COPY --chown=superset superset_config.py /app/
COPY --chown=superset entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh
ENV SUPERSET_CONFIG_PATH /app/superset_config.py
EXPOSE 8088