#!/bin/bash

LOGFILE="/var/log/backup-home.log"
LOCKFILE="/var/run/backup-home.lock"
SOURCE="/home/badal"
MOUNT_POINT="/media/badal/NewVolume1"
BACKUP_DIR="${MOUNT_POINT}/Backup"
MIN_SPACE_GB=10
MAX_LOG_SIZE=10485760
BACKUP_USER="badal"

EXCLUDE_PATTERNS=(
  'Android/'
  'go/pkg/'
  'snap/firefox/'
  'snap/firmware-updater/'
  'AndroidStudioProjects/'
  '.cache/'
  '.tmux/plugins/*'
  '.zen/'
  '.local/share/*'
  '.local/state/*'
  '**/Cache/'
  '**/cache/'
  '**/.cache/'
  '.npm/_cacache/'
  '.npm/_logs/'
  '.gradle/caches/'
  '.gradle/daemon/'
  '.gradle/wrapper/dists/'
  '.android/cache/'
  '.android/avd/*.avd/snapshots/'
  '.android/avd/*.avd/cache/'
  '.docker/tmp/'
  '.docker/overlay2/'
  'snap/*/.cache/'
  'snap/*/cache/'
  '.config/Code/Cache/'
  '.config/Brave*'
  '.config/Code/CachedData/'
  '.config/Code/CachedExtensions/'
  '.config/Code/logs/'
  '.config/Code/User/History/'
  '.config/Code/User/workspaceStorage/'
  '.vscode/extensions/*/node_modules/'
  '.mozilla/firefox/*/cache2/'
  '.mozilla/firefox/*/Cache/'
  '.mozilla/firefox/*/storage/temporary/'
  '.zen/*/cache2/'
  '.zen/*/Cache/'
  '**/build/'
  '**/.gradle/'
  '**/node_modules/'
  '**/.expo/'
  '**/.next/'
  '**/.nuxt/'
  '**/dist/'
  '**/__pycache__/'
  '**/*.pyc'
  '**/.pytest_cache/'
  '**/venv/'
  '**/env/'
  '**/.venv/'
  '**/target/'
  'go/pkg/mod/cache/'
  '.cargo/registry/'
  '.cargo/git/'
  '.rustup/toolchains/*/share/'
  '.lesshst'
  '*.log'
  '*.tmp'
  '*.temp'
  '*.swp'
  '*.swo'
  '*~'
  '.DS_Store'
  '.Trash*'
  'lost+found/'
  '.thumbnails/'
  '.gvfs/'
  '.Private/'
)

log_message() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

send_notification() {
  local title="$1"
  local message="$2"
  local urgency="${3:-normal}"
  local icon="${4:-drive-harddisk}"
  
  if command -v notify-send &> /dev/null; then
    for display in /tmp/.X11-unix/X*; do
      display_num="${display##*X}"
      sudo -u "$BACKUP_USER" DISPLAY=":${display_num}" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u $BACKUP_USER)/bus" \
        notify-send -u "$urgency" -i "$icon" -a "Backup System" "$title" "$message" 2>/dev/null
    done
  fi
}

rotate_logs() {
  if [ -f "$LOGFILE" ] && [ $(stat -c%s "$LOGFILE" 2>/dev/null || echo 0) -gt $MAX_LOG_SIZE ]; then
    mv "$LOGFILE" "${LOGFILE}.old"
    gzip -f "${LOGFILE}.old" 2>/dev/null
    log_message "Log file rotated and compressed"
  fi
}

check_lock() {
  if [ -f "$LOCKFILE" ]; then
    PID=$(cat "$LOCKFILE")
    if ps -p "$PID" > /dev/null 2>&1; then
      log_message "ERROR: Backup already running (PID: $PID)"
      send_notification "Backup Skipped" "Another backup is already running" "low" "dialog-warning"
      exit 1
    else
      log_message "Removing stale lock file"
      rm -f "$LOCKFILE"
    fi
  fi
  echo $$ > "$LOCKFILE"
}

cleanup() {
  rm -f "$LOCKFILE"
}

trap cleanup EXIT

rotate_logs
check_lock

log_message "=== Starting backup process ==="
send_notification "Backup Started" "Backing up /home/badal..." "low" "drive-harddisk"

if ! mountpoint -q "$MOUNT_POINT"; then
  log_message "ERROR: Backup drive not mounted at $MOUNT_POINT"
  send_notification "Backup Failed" "Backup drive not mounted" "critical" "dialog-error"
  exit 1
fi

log_message "Backup drive mounted at $MOUNT_POINT"

AVAILABLE_SPACE=$(df -BG "$MOUNT_POINT" | awk 'NR==2 {print $4}' | sed 's/G//')
if [ "$AVAILABLE_SPACE" -lt "$MIN_SPACE_GB" ]; then
  log_message "ERROR: Insufficient disk space. Available: ${AVAILABLE_SPACE}GB, Required: ${MIN_SPACE_GB}GB"
  send_notification "Backup Failed" "Low disk space: ${AVAILABLE_SPACE}GB available" "critical" "dialog-error"
  exit 1
fi
log_message "Available disk space: ${AVAILABLE_SPACE}GB"

if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
  log_message "Created backup directory: $BACKUP_DIR"
fi

log_message "Starting rsync backup..."

EXCLUDE_ARGS=()
for pattern in "${EXCLUDE_PATTERNS[@]}"; do
  EXCLUDE_ARGS+=("--exclude=$pattern")
done

START_TIME=$(date +%s)

rsync -avh --progress \
  "${EXCLUDE_ARGS[@]}" \
  "$SOURCE/" "$BACKUP_DIR/" 2>&1 | tee -a "$LOGFILE"

RSYNC_EXIT=${PIPESTATUS[0]}
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
DURATION_MIN=$((DURATION / 60))
DURATION_SEC=$((DURATION % 60))

if [ $RSYNC_EXIT -eq 0 ]; then
  log_message "Backup completed successfully in ${DURATION_MIN}m ${DURATION_SEC}s"
  BACKUP_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
  log_message "Backup size: $BACKUP_SIZE"
  FILE_COUNT=$(find "$BACKUP_DIR" -type f 2>/dev/null | wc -l)
  log_message "Total files in backup: $FILE_COUNT"
  
  send_notification "Backup Complete" "Time: ${DURATION_MIN}m ${DURATION_SEC}s\nSize: $BACKUP_SIZE\nFiles: $FILE_COUNT" "normal" "emblem-default"
else
  log_message "ERROR: Backup failed with exit code $RSYNC_EXIT"
  send_notification "Backup Failed" "Check logs for details" "critical" "dialog-error"
  exit 1
fi

log_message "=== Backup process finished ==="
