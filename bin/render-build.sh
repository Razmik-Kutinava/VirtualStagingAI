#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Ensure storage directories exist
# Render mounts disk at /rails/storage
if [ -d "/rails/storage" ]; then
  # Use Render's mounted disk
  mkdir -p /rails/storage
else
  # Local development - use storage/ directory
  mkdir -p storage
fi

# Build Tailwind CSS
bundle exec rails tailwindcss:build

# Precompile assets
bundle exec rails assets:precompile

# Create database if it doesn't exist
bundle exec rails db:create || true

# Run database migrations
bundle exec rails db:migrate
