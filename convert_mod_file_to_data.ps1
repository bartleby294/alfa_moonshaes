$confirmation = Read-Host "Running this script will delete the existing data directory and create a new data directory from the contents of the current module. Do you wish to continue?: (Y/N)"

# If confirmed delete old data directory and assemble mod.
if ($confirmation -eq 'y' -or $confirmation -eq 'Y') {
    # Get the scripts current directory
	$script_dir = Split-Path $MyInvocation.MyCommand.Path -Parent

	# Remove the data directory if it exists
	Remove-Item $script_dir/data -Recurse -ErrorAction Ignore

	# Create the data direcotry 
	New-Item -Path $script_dir/data -ItemType Directory

	cd $script_dir/data
	
	# Extract data from current module.
	../bin/ErfUtil.exe -1 -x -r ..\build\alfa_moonshaes.mod
	
	cd $script_dir
}