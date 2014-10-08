$object = New-Object -ComObject shell.Application
$folder = $object.BrowseForFolder(0,"What folder do you want to watch",0)

if($folder.self.path -ne $null)
{
    #Finds the path to this script during runtime
    $thisScript = $MyInvocation.MyCommand.Path
    $file = Get-ChildItem $thisScript
    $dir = $file.Directory.FullName

    #Finds the script to insert path into
    $scriptToChange = $dir + "\Listener.ps1"

    #The path to insert into your script
    $changeLineTo = '$location = ' + '"' + $folder.self.path + '"'

    #Inserts your new path
    $out = @()
    $count = 0
    foreach ($line in $(Get-Content $scriptToChange)){
        $count+=1
        if ($count -eq 6){
            $line = $changeLineTo
        }
        $out += $line
    }
    $out | Out-File -FilePath $scriptToChange

    write-host ""
    write-host "Now we're underway. Enter your credentials and the correct adress to your server in the Start script!"
    write-host ""
}