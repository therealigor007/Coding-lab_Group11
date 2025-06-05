#!/bin/bash

# Define base path for logs (adjust to your structure)
LOG_DIR="../active_logs"
ARCHIVE_DIR_BASE="hospital-monitoring-system/archive_logs"

echo "Select log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter choice (1-3): " choice

# Validate input is 1, 2, or 3
if ! [[ "$choice" =~ ^[1-3]$ ]]; then
  echo "Invalid choice. Please enter 1, 2, or 3."
  exit 1
fi

# Set variables based on choice
case $choice in
  1)
    LOG_FILE="$LOG_DIR/heart_rate.log"
    ARCHIVE_DIR="$ARCHIVE_DIR_BASE/heart_data_archive"
    LOG_BASE_NAME="heart_rate"
    ;;
  2)
    LOG_FILE="$LOG_DIR/temperature.log"
    ARCHIVE_DIR="$ARCHIVE_DIR_BASE/temperature_data_archive"
    LOG_BASE_NAME="temperature"
    ;;
  3)
    LOG_FILE="$LOG_DIR/water_usage.log"
    ARCHIVE_DIR="$ARCHIVE_DIR_BASE/water_usage_data_archive"
    LOG_BASE_NAME="water_usage"
    ;;
esac

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file $LOG_FILE does not exist. Cannot archive."
  exit 1
fi

# Check if archive directory exists, create if missing
if [ ! -d "$ARCHIVE_DIR" ]; then
  echo "Archive directory $ARCHIVE_DIR does not exist. Creating it now."
  mkdir -p "$ARCHIVE_DIR"
  if [ $? -ne 0 ]; then
    echo "Failed to create archive directory. Exiting."
    exit 1
  fi
fi

# Create timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")

# Archive filename
ARCHIVE_FILE="${ARCHIVE_DIR}/${LOG_BASE_NAME}_${TIMESTAMP}.log"

echo "Archiving $LOG_FILE..."

# Move the log file to archive with timestamped name
mv "$LOG_FILE" "$ARCHIVE_FILE"
if [ $? -ne 0 ]; then
  echo "Failed to move log file to archive. Exiting."
  exit 1
fi

# Create new empty log file to continue monitoring
touch "$LOG_FILE"
if [ $? -ne 0 ]; then
  echo "Failed to create new log file. Exiting."
  exit 1
fi

echo "Successfully archived to $ARCHIVE_FILE"