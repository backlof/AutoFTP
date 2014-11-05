#   AutoFTP

The scripts listen for new files of a specific file extension, and uploads them to an FTP server.

**All the scripts have to be in the same folder**

###  Enable Powershell on your computer

- Start menu
- Type Windows Powershell
- Copy the command
```
Set-ExecutionPolicy RemoteSigned
```
- Paste it into console
- Enter

###  Choose location for script to monitor

- Right click *Folder.ps1*
- Hit `Run with Powershell`

You can do this many times

###  Customize information

- Open `Listener.ps1` in a text editor
- Find the following lines
```
$serverAdress = "YOUR SERVER/"
$uploadDir = "UPLOAD DIRECTORY/"
$username = "YOUR USERNAME"
$password = "YOUR PASSWORD"
```
- Enter your credentials
- Replace all instances of `FILETYPE` with the file extension you want
```
$fsw = New-Object IO.FileSystemWatcher $location, "*.FILETYPE" -Property @{
```

###	Start the script

- Right click *Start.ps1*
- Hit *"Run with Powershell"*

You can stop the script by closing the console or running *Stop.ps1*
