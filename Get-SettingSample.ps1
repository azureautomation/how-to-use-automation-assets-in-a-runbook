<#
.SYNOPSIS
    Shows how to retrieve existing variables, credentials, certificates and connections

.DESCRIPTION
   This Runbook sample demonstrates the use of global assets in Automation.  It shows how 
   to retrieve an existing global variable, connection, certificate and credential.  
   This runbook gets the value of the assets and prints the variable, 
   credential, connection and certificate properties. 
   
   WARNING: For this runbook to work, you must have created the 
   following settings: variable, connection, credential & certificate. 

.PARAMETER MyVariable
    String name of the string variable saved in global assets

.PARAMETER MyConnection
    String name of an Azure Automation connection stored in global assets 
                 
.PARAMETER MyCredential
    String name of the PSCredential stored in global assets 

.PARAMETER MyCert
    String name of the certificate uploaded to global assets

.NOTES
	Author: System Center Automation Team 
	Last Updated: 2/14/2014   
#>

workflow Get-SettingSample
{   
      param( 
                  
        # Variable
        [parameter(Mandatory=$true)]
        [String]$MyVariable,

        # Connection
        [parameter(Mandatory=$true)]
        [String]$MyConnection,

        # Credential 
        [parameter(Mandatory=$true)]
        [String]$MyCredential,

        # Certificate
        [parameter(Mandatory=$true)]
        [String]$MyCert

    )

    # Get the global variable
    $Var = Get-AutomationVariable -Name $MyVariable
    if ($Var -eq $null)
    {
        Write-Output "Variable entered: $MyVariable does not exist in the automation service. Please create one `n"   
    }
    else
    {
        Write-Output "Variable Properties: "
        Write-Output "Variable Value: $Var `n"
    }
  
    # Get the Azure Automation Connection
    # Prints connection properties
    $Con = Get-AutomationConnection -Name $MyConnection
    if ($Con -eq $null)
    {
        Write-Output "Connection entered: $MyConnection does not exist in the automation service. Please create one `n"   
    }
    else
    {
        $SubscriptionID = $Con.SubscriptionID
        $ManagementCertificate = $Con.AutomationCertificateName
       
        Write-Output "Connection Properties: "
        Write-Output "SubscriptionID: $SubscriptionID"
        Write-Output "Certificate setting name: $ManagementCertificate `n"
    }   
  
    # Get the PowerShell credential and prints its properties
    $Cred = Get-AutomationPSCredential -Name $MyCredential
    if ($Cred -eq $null)
    {
        Write-Output "Credential entered: $MyCredential does not exist in the automation service. Please create one `n"   
    }
    else
    {
        $CredUsername = $Cred.UserName
        $CredPassword = $Cred.GetNetworkCredential().Password
        
        Write-Output "Credential Properties: "
        Write-Output "Username: $CredUsername"
        Write-Output "Password: $CredPassword `n"
    }

    # Get Certificate & print out its properties
    $Cert = Get-AutomationCertificate -Name $MyCert
    if ($Cert -eq $null)
    {
        Write-Output "Certificate entered: $MyCert does not exist in the automation service. Please create one `n"   
    }
    else
    {
        $Thumbprint = $Cert.Thumbprint
        
        Write-Output "Certificate Properties: "
        Write-Output "Thumbprint: $Thumbprint"
    }
}
