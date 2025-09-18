#!/bin/sh
set -e

# Only build once, not on every container start
if [ ! -d "/var/www/node_modules" ]; then
  yarn install
fi

yarn build

# Start dev server on all interfaces (0.0.0.0) so ECS can access it
yarn dev --host 0.0.0.0
