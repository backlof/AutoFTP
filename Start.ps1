$thisScript = $MyInvocation.MyCommand.Path
$file = Get-ChildItem $thisScript
$dir = $file.Directory.FullName

#Starts the folder monitor (with FTP upload)
$scriptToRun = $dir + "\Listener.ps1"

powershell.exe -NoExit -File $scriptToRun