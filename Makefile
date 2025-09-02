.PHONY: up down logs ps rebuild clean

up:
	docker compose up -d --build

down:
	docker compose down

logs:
	docker compose logs -f mcp-server-qdrant

ps:
	docker compose ps

rebuild:
	docker compose build --no-cache mcp-server-qdrant

clean:
	docker compose down -v
