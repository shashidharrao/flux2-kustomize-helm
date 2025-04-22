#!/bin/bash

# Configuration
GITHUB_TOKEN="your_github_token" # Replace with your GitHub Personal Access Token
GITHUB_OWNER="your_github_username_or_org" # Replace with your GitHub username or organization
GITHUB_REPO="your_repo_name" # Replace with the repository name
S3_BUCKET_NAME="your_s3_bucket_name" # Replace with your S3 bucket name
S3_REGION="your_s3_region" # Replace with your S3 region, e.g., us-east-1
BACKUP_DIR="/tmp/github_backup" # Temporary backup directory

# GitHub API URL
GITHUB_API_URL="https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPO}/tarball"

# Timestamp for the backup
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Backup file name
BACKUP_FILE="${GITHUB_REPO}-${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "${BACKUP_DIR}"

# Download GitHub repository as a tarball
echo "Downloading repository from GitHub..."
curl -H "Authorization: token ${GITHUB_TOKEN}" -L "${GITHUB_API_URL}" -o "${BACKUP_DIR}/${BACKUP_FILE}"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download repository from GitHub."
    exit 1
fi

echo "Repository downloaded to ${BACKUP_DIR}/${BACKUP_FILE}"

# Upload the tarball to S3
echo "Uploading backup to S3 bucket ${S3_BUCKET_NAME}..."
aws s3 cp "${BACKUP_DIR}/${BACKUP_FILE}" "s3://${S3_BUCKET_NAME}/" --region "${S3_REGION}"

if [ $? -ne 0 ]; then
    echo "Error: Failed to upload backup to S3."
    exit 1
fi

echo "Backup successfully uploaded to S3 bucket ${S3_BUCKET_NAME}."

# Clean up
echo "Cleaning up temporary files..."
rm -f "${BACKUP_DIR}/${BACKUP_FILE}"

echo "Backup completed successfully."
