﻿<#
    This is a script for automated uploading of new files to an FTP server
#>

#LINE BELOW HAS TO BE AT LINE NUMBER 6. DO NOT CHANGE!
$location = "Choose this directory"

$fsw = New-Object IO.FileSystemWatcher $location, "*.FILETYPE" -Property @{
    IncludeSubdirectories = $false
    NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'
}

write-host ""; write-host "Listens for added files in: " -nonewline; write-host $location -foregroundcolor yellow; write-host ""


#Variables from outside the event aren't brought with
$onCreated = Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {

    # Add the credentials to your FTP server below

    $serverAdress = "YOUR SERVER/"
    $uploadDir = "UPLOAD DIRECTORY/"
    $username = "YOUR USERNAME"
    $password = "YOUR PASSWORD"

    #
    #
    #
    #
    #

    #String variable only
    $path = $Event.SourceEventArgs.FullPath
    $file = Get-ChildItem $path

    write-host ""
    write-host ""
    write-host "File added: " -nonewline; write-host $file.Name
    write-host "Searching through: " -nonewline; write-host $file.Directory.FullName
    write-host ""

    #ftp server 
    $ftp = "ftp://" + $serverAdress + $uploadDir
    
    $webclient = New-Object System.Net.WebClient 
     
    $webclient.Credentials = New-Object System.Net.NetworkCredential($username,$password)

    #list every sql server trace file 
    foreach($item in (dir $file.Directory "*.FILETYPE"))
    {
        write-host "Uploading $item ... " -nonewline
        $uri = New-Object System.Uri($ftp+$item.Name)

        try{
            $webclient.UploadFile($uri, $item.FullName)
            write-host "Uploaded and removed" -foregroundcolor green
            Remove-Item $item.FullName
        }
        catch{
            #Unknown error trying to upload to server
            write-host "Can't upload the file" -foregroundcolor red
        }
    }
    write-host ""
}
