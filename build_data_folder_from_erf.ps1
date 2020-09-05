$confirmation = Read-Host "Running this script will add the contents of all erfs in the erfs directory to your data folder. Do you wish to continue?: (Y/N)"

# If confirmed delete old data directory and assemble mod.
if ($confirmation -eq 'y' -or $confirmation -eq 'Y') {
    # Get the scripts current directory
	$script_dir = Split-Path $MyInvocation.MyCommand.Path -Parent

	cd $script_dir/data
	
	$fileNames = Get-ChildItem -Path ..\erfs -Recurse -Include *.erf
	
	Foreach ($file in $fileNames) {
		# Extract data from current module.
		../bin/ErfUtil.exe -1 -x -r $file
	}
	
	cd $script_dir
}