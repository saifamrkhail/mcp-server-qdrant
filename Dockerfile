FROM python:3.11-slim

WORKDIR /app

# Install curl (and CA certs) on slim base
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install uv for package management
RUN pip install --no-cache-dir uv

# Install the mcp-server-qdrant package
RUN uv pip install --system --no-cache-dir mcp-server-qdrant

# Expose the default port for SSE transport
EXPOSE 8000

# Set environment variables with defaults that can be overridden at runtime
ENV QDRANT_URL="http://qdrant:6333"
#ENV QDRANT_API_KEY=""
ENV COLLECTION_NAME="qdrantdb"
ENV EMBEDDING_MODEL="sentence-transformers/all-MiniLM-L6-v2"

# Run the server with streamable-http transport for remote client
 CMD uvx mcp-server-qdrant --transport streamable-http
