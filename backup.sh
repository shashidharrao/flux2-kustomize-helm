#!/bin/bash

# Load environment variables from config.env
source ../config/config.env

# Check if the repository URL is provided
if [ -z "$GITHUB_REPO_URL" ]; then
  echo "Error: GITHUB_REPO_URL is not set in config.env"
  exit 1
fi

# Define backup directory and tarball name
BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
TARBALL_NAME="${BACKUP_DIR}.tar.gz"

# Clone the GitHub repository
git clone "$GITHUB_REPO_URL" "$BACKUP_DIR"

# Check if the clone was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to clone the repository."
  exit 1
fi

# Compress the backup directory into a tarball
tar -czf "$TARBALL_NAME" "$BACKUP_DIR"

# Check if the tarball creation was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to create the tarball."
  exit 1
fi

# Clean up the backup directory
rm -rf "$BACKUP_DIR"

echo "Backup created successfully: $TARBALL_NAME"