# Remove MacOS Configuration Profiles

## Purpose
Can be used in recovery mode to automically remove and recreate the /var/db/ConfigurationProfiles directory. This is useful when you are trying to remove MDM profiles that are locked and need to be removed.


## How To Use

1. Turn the Mac off

2. Hold down the power button until "Loading Startup Options" appears

3. Select Options

4. Go to Utilities->Terminal

5. Ensure the Mac is connected to the internet

6. Run the command curl -fsSL https://raw.githubusercontent.com/teshst/remove-configuration-profiles-macos/refs/heads/main/remove-config-profiles.sh | sh

7. If you see the output "Operation completed successfully." you can restart