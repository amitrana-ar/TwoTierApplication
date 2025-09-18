#!/bin/sh
set -e

# Install PHP dependencies
composer install --no-interaction --prefer-dist --optimize-autoloader

# Clear caches
php artisan config:clear
php artisan route:clear
php artisan cache:clear

# Run migrations (optional)
# php artisan migrate --force

exec "$@"
