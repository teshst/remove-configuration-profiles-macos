#!/bin/zsh

# Attempts to find a volume that includes "- Data" to figure out the name of the matching root volume
find_root_volume() {
  
  local base_dir="/Volumes"

  # Loop through all volumes in the base directory
  for volume in "$base_dir"/*; do
    if [ -d "$volume" ]; then
      local volume_name=$(basename "$volume")
      local data_volume="$base_dir/$volume_name - Data"

      # Check if the Data volume exists
      if [ -d "$data_volume" ]; then
        echo "$volume"
        return 0
      fi
    fi
  done

  return 1
}

# Removes and creates the /var/db/ConfigurationProfiles directory
recreate_config_directory() {

  # Defines the target directory and settings directory
  local target_dir="$1"

  # Remove existing files in the specified directory
  echo "Removing files in $target_dir"
  rm -rf "$target_dir"

  # Create configurations profiles directory
  echo "Creating directory $1"
  mkdir -p "$target_dir/Settings"

  # Create the '.profilesAreInstalled' file
  echo "Creating file $target_dir/Settings/.profilesAreInstalled."
  touch "$target_dir/Settings/.profilesAreInstalled"
}

# Call the function to find the root volume
root_volume="$(find_root_volume)"

# If default directory Macintosh HD
if [ -d "/Volumes/Macintosh HD" ]; then

  # Defines the target directory and settings directory
  target_dir="/Volumes/Macintosh HD/var/db/ConfigurationProfiles"

  # Ensure the target directory exists
  if [ ! -d "$target_dir" ]; then
    echo "Error: Target directory $target_dir does not exist."
    exit 1
  fi

  # Removes and creates the /var/db/ConfigurationProfiles directory
  recreate_config_directory "$target_dir"

  echo "Operation completed successfully."

# If Macintosh HD doesn't exist than try to find the root volume
elif [ -n "$root_volume" ]; then

  echo "Found root volume: $root_volume"

  # Defines the target directory and settings directory
  target_dir="$root_volume/var/db/ConfigurationProfiles"

  # Check if the target directory exists
  if [ ! -d "$target_dir" ]; then
    echo "Error: Target directory $target_dir does not exist."
    exit 1
  fi

  # Removes and creates the /var/db/ConfigurationProfiles directory
  recreate_config_directory "$target_dir"

  echo "Operation completed successfully."

else
  echo "Error: Could not find the root volume"
  ls /Volumes
  exit 1
fi