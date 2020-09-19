$confirmation = Read-Host "Running this script will extract the contents of all erfs in the erfs directory to your erf_data folder. Do you wish to continue?: (Y/N)"

# 
if ($confirmation -eq 'y' -or $confirmation -eq 'Y') {
    # Get the scripts current directory
	$script_dir = Split-Path $MyInvocation.MyCommand.Path -Parent

	if(-Not (Test-Path -Path $script_dir/erfs_data)) {
		New-Item -Path $script_dir -Name "erfs_data" -ItemType "directory"
	}
	
	cd $script_dir/erfs_data
	
	$fileNames = Get-ChildItem -Path ..\erfs -Recurse -Include *.erf
	
	Foreach ($file in $fileNames) {
		# Extract data from current module.
		../bin/ErfUtil.exe -1 -x -r $file
	}
	
	cd $script_dir
}