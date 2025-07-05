#!/bin/bash

# Docker Compose development helper script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker and Docker Compose are installed
check_dependencies() {
    print_status "Checking dependencies..."
    
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
    
    print_success "Dependencies check passed"
}

# Build all services
build() {
    print_status "Building all Docker services..."
    docker-compose build
    print_success "Build completed"
}

# Start all services
up() {
    print_status "Starting all services..."
    docker-compose up -d
    print_success "All services started"
    print_status "Services available at:"
    echo "  - User Web: http://localhost:3000"
    echo "  - Admin Web: http://localhost:3002"
    echo "  - Rails API: http://localhost:3001"
    echo "  - PostgreSQL: localhost:5432"
}

# Start services with logs
up_logs() {
    print_status "Starting all services with logs..."
    docker-compose up
}

# Stop all services
down() {
    print_status "Stopping all services..."
    docker-compose down
    print_success "All services stopped"
}

# Show service status
status() {
    print_status "Service status:"
    docker-compose ps
}

# Show logs
logs() {
    if [ -z "$1" ]; then
        docker-compose logs -f
    else
        docker-compose logs -f "$1"
    fi
}

# Clean up everything
clean() {
    print_warning "This will remove all containers, volumes, and images. Continue? (y/N)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        print_status "Cleaning up..."
        docker-compose down -v --rmi all
        docker system prune -f
        print_success "Cleanup completed"
    else
        print_status "Cleanup cancelled"
    fi
}

# Restart specific service
restart() {
    if [ -z "$1" ]; then
        print_error "Please specify a service name (rails-api, user-web, admin-web, postgres)"
        exit 1
    fi
    
    print_status "Restarting $1..."
    docker-compose restart "$1"
    print_success "$1 restarted"
}

# Execute command in container
exec_cmd() {
    if [ -z "$1" ]; then
        print_error "Please specify a service name"
        exit 1
    fi
    
    service="$1"
    shift
    docker-compose exec "$service" "$@"
}

# Database operations
db_create() {
    print_status "Creating database..."
    docker-compose exec rails-api bundle exec rails db:create
}

db_migrate() {
    print_status "Running database migrations..."
    docker-compose exec rails-api bundle exec rails db:migrate
}

db_seed() {
    print_status "Seeding database..."
    docker-compose exec rails-api bundle exec rails db:seed
}

db_setup() {
    print_status "Setting up database..."
    docker-compose exec rails-api bundle exec rails db:setup
}

# Show usage
usage() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  build           Build all Docker services"
    echo "  up              Start all services in background"
    echo "  up-logs         Start all services with logs"
    echo "  down            Stop all services"
    echo "  status          Show service status"
    echo "  logs [service]  Show logs (optionally for specific service)"
    echo "  clean           Remove all containers, volumes, and images"
    echo "  restart <svc>   Restart specific service"
    echo "  exec <svc> <cmd> Execute command in container"
    echo "  db:create       Create database"
    echo "  db:migrate      Run database migrations"
    echo "  db:seed         Seed database"
    echo "  db:setup        Setup database (create + migrate + seed)"
    echo ""
    echo "Services: rails-api, user-web, admin-web, postgres"
    echo ""
    echo "Examples:"
    echo "  $0 up                          # Start all services"
    echo "  $0 logs rails-api              # Show Rails API logs"
    echo "  $0 exec rails-api rails console # Open Rails console"
    echo "  $0 restart user-web            # Restart user-web service"
}

# Main script logic
case "$1" in
    build)
        check_dependencies
        build
        ;;
    up)
        check_dependencies
        up
        ;;
    up-logs)
        check_dependencies
        up_logs
        ;;
    down)
        down
        ;;
    status)
        status
        ;;
    logs)
        logs "$2"
        ;;
    clean)
        clean
        ;;
    restart)
        restart "$2"
        ;;
    exec)
        shift
        exec_cmd "$@"
        ;;
    db:create)
        db_create
        ;;
    db:migrate)
        db_migrate
        ;;
    db:seed)
        db_seed
        ;;
    db:setup)
        db_setup
        ;;
    *)
        usage
        exit 1
        ;;
esac