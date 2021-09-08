<#       
    .SYNOPSIS
    Force Cluster Owner to a specific server

    .DESCRIPTION
    https://kb.paessler.com/en/topic/40713-can-i-automatically-restart-a-windows-service-with-prtg
    Copy this script to the main PRTG server's Notifications\EXE scripts folder (${env:ProgramFiles(x86)}\PRTG Network Monitor\Notifications\EXE)
    and create a new Notification Template > Execute Program. Choose this script from the dropdown and provide the SERVERNAME as a parameter.
    The Credentials need to be generated under the instance that PRTG is running as (NT Authority\System). These domain creds allow PRTG
    to remotely run code on the remote system and manipulate the Cluster Groups.
    
    .PARAMETER Server
    Server FQDN or NetBIOS Name
    
    .EXAMPLE
    Sample call from PRTG EXE/Script Advanced
    PRTG-MSCluster-MoveClusterGroup.ps1 EXCHANGE01

    Author:  Greg Beifuss
    7:48 AM 9/8/2021
#>

param(
    [string]$Server = $null
)

$id = Import-Clixml "C:\Program Files (x86)\PRTG Network Monitor\Notifications\EXE\powershell.xml"
$Scriptblock = {
Get-ClusterGroup | Move-ClusterGroup -Node $env:COMPUTERNAME
}
Invoke-Command -ComputerName $Server -ScriptBlock $Scriptblock -Credential $id
