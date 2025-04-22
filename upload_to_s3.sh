#!/bin/bash

# Load environment variables from config.env
source ../config/config.env

# Check if the backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
  echo "Backup file not found!"
  exit 1
fi

# Upload the backup file to the specified S3 bucket
aws s3 cp "$BACKUP_FILE" "s3://$S3_BUCKET_NAME/"

if [ $? -eq 0 ]; then
  echo "Backup uploaded successfully to s3://$S3_BUCKET_NAME/"
else
  echo "Failed to upload backup to S3."
  exit 1
fi