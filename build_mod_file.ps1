$confirmation = Read-Host "Running this script will delete the existing build directory and create a new module from the contents of the data directory. Do you wish to continue?: (Y/N)"

# If confirmed delete old build directory and assemble mod.
if ($confirmation -eq 'y' -or $confirmation -eq 'Y') {
    # Get the scripts current directory
	$script_dir = Split-Path $MyInvocation.MyCommand.Path -Parent

	# Remove the build directory if it exists
	Remove-Item $script_dir/build -Recurse -ErrorAction Ignore

	# Create the build direcotry 
	New-Item -Path $script_dir/build -ItemType Directory

	# Compile mod from data
	bin/ErfUtil.exe -1 -c build/alfa_moonshaes.mod -z data/*
}