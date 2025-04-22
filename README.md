# GitHub Backup Project

This project provides a simple way to back up a GitHub repository and upload the backup to an Amazon S3 bucket. It consists of two main scripts: one for creating the backup and another for uploading it to S3.

## Project Structure

```
github-backup-project
├── scripts
│   ├── backup.sh        # Script to create a backup of the GitHub repository
│   └── upload_to_s3.sh  # Script to upload the backup to an S3 bucket
├── config
│   └── config.env       # Environment variables for the scripts
├── logs
│   └── .gitkeep         # Keeps the logs directory tracked by Git
├── README.md            # Project documentation
└── .gitignore           # Files and directories to ignore in Git
```

## Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd github-backup-project
   ```

2. **Configure environment variables**:
   Edit the `config/config.env` file to include your GitHub repository URL and S3 bucket name. Example:
   ```
   GITHUB_REPO_URL=https://github.com/username/repository.git
   S3_BUCKET_NAME=my-s3-bucket
   ```

3. **Install AWS CLI**:
   Make sure you have the AWS CLI installed and configured with your credentials. You can install it by following the instructions on the [AWS CLI installation page](https://aws.amazon.com/cli/).

## Usage

To create a backup of the GitHub repository, run the following command:
```bash
bash scripts/backup.sh
```

After creating the backup, upload it to your S3 bucket with:
```bash
bash scripts/upload_to_s3.sh
```

## License

This project is licensed under the MIT License. See the LICENSE file for more details.