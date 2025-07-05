.PHONY: help build up down status logs clean restart db-create db-migrate db-seed db-setup

# デフォルトターゲット
help: ## このヘルプメッセージを表示
	@echo "Rails Next Template - Docker Development Commands"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# DockerとDocker Composeが利用可能かチェック
check-docker:
	@which docker > /dev/null || (echo "Docker is not installed" && exit 1)
	@which docker-compose > /dev/null || (echo "Docker Compose is not installed" && exit 1)

# 全サービスのビルド
build: check-docker ## 全Dockerサービスをビルド
	@echo "Building all Docker services..."
	docker-compose build
	@echo "Build completed ✅"

# 全サービスをバックグラウンドで起動
up: check-docker ## 全サービスをバックグラウンドで起動
	@echo "Starting all services..."
	docker-compose up -d
	@echo "All services started ✅"
	@echo ""
	@echo "Services available at:"
	@echo "  - User Web:   http://localhost:3000"
	@echo "  - Admin Web:  http://localhost:3002"
	@echo "  - Rails API:  http://localhost:3001"
	@echo "  - PostgreSQL: localhost:5432"

# ログ付きでサービスを起動
up-logs: check-docker ## 全サービスをログ付きで起動（フォアグラウンド）
	@echo "Starting all services with logs..."
	docker-compose up

# 全サービスを停止
down: ## 全サービスを停止
	@echo "Stopping all services..."
	docker-compose down
	@echo "All services stopped ✅"

# サービス状態を表示
status: ## サービス状態を表示
	@echo "Service status:"
	docker-compose ps

# ログを表示（使用方法: make logs service=rails-api）
logs: ## 全サービスまたは特定サービスのログを表示（make logs service=rails-api）
ifdef service
	docker-compose logs -f $(service)
else
	docker-compose logs -f
endif

# 全クリーンアップ
clean: ## 全コンテナ、ボリューム、イメージを削除
	@echo "⚠️  This will remove all containers, volumes, and images."
	@echo "Continue? [y/N] " && read ans && [ $${ans:-N} = y ]
	@echo "Cleaning up..."
	docker-compose down -v --rmi all
	docker system prune -f
	@echo "Cleanup completed ✅"

# 特定サービスを再起動（使用方法: make restart service=rails-api）
restart: ## 特定サービスを再起動（make restart service=rails-api）
ifndef service
	$(error Please specify a service: make restart service=rails-api)
endif
	@echo "Restarting $(service)..."
	docker-compose restart $(service)
	@echo "$(service) restarted ✅"

# コンテナ内でコマンドを実行（使用方法: make exec service=rails-api cmd="rails console"）
exec: ## コンテナ内でコマンドを実行（make exec service=rails-api cmd="rails console"）
ifndef service
	$(error Please specify a service: make exec service=rails-api cmd="rails console")
endif
ifndef cmd
	$(error Please specify a command: make exec service=rails-api cmd="rails console")
endif
	docker-compose exec $(service) $(cmd)

# データベース操作
db-create: ## データベースを作成
	@echo "Creating database..."
	docker-compose exec rails-api bundle exec rails db:create
	@echo "Database created ✅"

db-migrate: ## データベースマイグレーションを実行
	@echo "Running database migrations..."
	docker-compose exec rails-api bundle exec rails db:migrate
	@echo "Migrations completed ✅"

db-seed: ## データベースにシードデータを投入
	@echo "Seeding database..."
	docker-compose exec rails-api bundle exec rails db:seed
	@echo "Database seeded ✅"

db-setup: ## データベースをセットアップ（作成 + マイグレーション + シード）
	@echo "Setting up database..."
	docker-compose exec rails-api bundle exec rails db:setup
	@echo "Database setup completed ✅"

db-reset: ## データベースをリセット（削除 + セットアップ）
	@echo "Resetting database..."
	docker-compose exec rails-api bundle exec rails db:drop db:setup
	@echo "Database reset completed ✅"

# Rails固有のコマンド
rails-console: ## Railsコンソールを開く
	docker-compose exec rails-api bundle exec rails console

rails-routes: ## Railsルートを表示
	docker-compose exec rails-api bundle exec rails routes

# 依存関係のインストール
install: ## 全サービスの依存関係をインストール
	@echo "Installing Rails dependencies..."
	docker-compose exec rails-api bundle install
	@echo "Installing Node.js dependencies for user-web..."
	docker-compose exec user-web pnpm install
	@echo "Installing Node.js dependencies for admin-web..."
	docker-compose exec admin-web pnpm install
	@echo "Dependencies installed ✅"

# テストコマンド
test-rails: ## Railsテストを実行
	docker-compose exec rails-api bundle exec rspec

test-user-web: ## user-webテストを実行
	docker-compose exec user-web pnpm test

test-admin-web: ## admin-webテストを実行
	docker-compose exec admin-web pnpm test

test: test-rails test-user-web test-admin-web ## 全テストを実行

# リントコマンド
lint-rails: ## Railsリントを実行
	docker-compose exec rails-api bundle exec rubocop

lint-user-web: ## user-webリントを実行
	docker-compose exec user-web pnpm lint

lint-admin-web: ## admin-webリントを実行
	docker-compose exec admin-web pnpm lint

lint: lint-rails lint-user-web lint-admin-web ## 全リントを実行

# 開発ワークフロー
dev: build up ## 開発環境をビルドして起動
	@echo ""
	@echo "🚀 Development environment is ready!"
	@echo ""
	@echo "Next steps:"
	@echo "  1. make db-setup    # Setup database"
	@echo "  2. make logs        # Watch logs"
	@echo ""

# 本番ビルド（将来の使用のため）
build-prod: ## 本番イメージをビルド
	docker-compose -f docker-compose.prod.yml build

# コンテナリソース使用量を表示
stats: ## コンテナリソース使用量を表示
	docker stats $$(docker-compose ps -q)