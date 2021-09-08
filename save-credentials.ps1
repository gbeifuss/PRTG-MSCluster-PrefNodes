#save-credentials.ps1

<#
How to save/use credentials via. CliXML
This uses the Windows data protection API, and the key used to encrypt the password is specific to both the user and the machine that the code is running under.
Launch a powershell instance under the credentials the script will run as, then generate the XML file with the necessary credentials
Read the saved XML from the script with something like $id = Import-Clixml $credFilePath

As a result, the encrypted credential cannot be imported by a different user nor the same user on a different computer.
https://stackoverflow.com/questions/40029235/save-pscredential-in-the-file
https://www.jaapbrasser.com/quickly-and-securely-storing-your-credentials-powershell/
https://masterandcmdr.com/2018/04/23/powershell-create-admin-credentials/

Greg Beifuss
2020-05-26 12:13
#>

$credFilePath = "C:\Program Files (x86)\PRTG Network Monitor\Notifications\EXE\powershell.xml" #xml file that holds the  admin login information
$credential = Get-Credential
$credential | Export-Clixml -Path $credFilePath

#validate the password by piping it back in
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR((Import-Clixml $credFilePath).password))
