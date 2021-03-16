$data = @{
AllNodes = @(
 
    @{
    NodeName = '*'
    PSDscAllowPlainTextPassword = $true
    PSDscAllowDomainUser = $true
 
    },
 
    @{
 
    NodeName = 'rdcb01.mehic.se'
    Role = 'Connection Broker'
 
    },
 
    @{
 
    NodeName = 'rdsh01.mehic.se'
    Role = 'Session Host'
 
    },
 
    @{
 
    NodeName = 'rdwa01.mehic.se'
    Role = 'Web Access'
 
    }
);
 
RDSData = @{
 
ConnectionBroker = 'rdcb01.mehic.se'
SessionHost = 'rdsh01.mehic.se'
WebAccessServer = 'rdwa01.mehic.se'
CollectionName = 'NM'
AutomaticReconnectionEnabled = $true
DisconnectedSessionLimitMin = 360
IdleSessionLimitMin = 360
BrokenConnectionAction = 'Disconnect'
UserGroup = 'RDS Users'
LicenseServer = 'rdcb01.mehic.se'
LicenseMode = 'PerUser'
 
}
 
}
 
Configuration RDS {
 
param (
 
[Parameter(Mandatory=$true)]
[pscredential]$domainadmin
 
)
#region DSC Resource Modules
#OBS!!! Be sure that the modules exist on the destination host servers
 
Import-DscResource -ModuleName PSDesiredStateConfiguration,
@{ModuleName='xRemoteDesktopSessionHost';ModuleVersion="1.8.0.0"}
 
#endregion
 
Node $AllNodes.Where{$_.Role -eq 'Connection Broker'}.NodeName {
$RDData = $data.RDSData
 
WindowsFeature RDSConnectionBroker {
 
Name = 'RDS-Connection-Broker'
Ensure = 'Present'
}
 
WindowsFeature RDLicensing
{
Ensure = "Present"
Name = "RDS-Licensing"
}
 
WaitForAll SessionHost {
 
NodeName = 'rdsh01.mehic.se'
ResourceName = '[WindowsFeature]SessionHost'
RetryIntervalSec = 15
RetryCount = 50
DependsOn = '[WindowsFeature]RDLicensing'
}
 
WaitForAll WebAccess {
 
NodeName = 'rdwa01.mehic.se'
ResourceName = '[WindowsFeature]WebAccess'
RetryIntervalSec = 15
RetryCount = 50
DependsOn = '[WaitForAll]SessionHost'
}
xRDSessionDeployment NewDeployment {
 
ConnectionBroker = $RDData.ConnectionBroker
SessionHost = $RDData.SessionHost
WebAccessServer = $RDData.WebAccessServer
DependsOn = '[WaitForAll]WebAccess'
PsDscRunAsCredential = $domainadmin
}
xRDSessionCollection collection {
 
CollectionName = $RDData.CollectionName
SessionHost = $RDData.SessionHost
ConnectionBroker = $RDData.ConnectionBroker
DependsOn = '[xRDSessionDeployment]NewDeployment'
PsDscRunAsCredential = $domainadmin
}
 
xRDSessionCollectionConfiguration collectionconfig {
 
CollectionName = $RDData.CollectionName
ConnectionBroker = $RDData.ConnectionBroker
AutomaticReconnectionEnabled = $true
DisconnectedSessionLimitMin = $RDData.DisconnectedSessionLimitMin
IdleSessionLimitMin = $RDData.IdleSessionLimitMin
BrokenConnectionAction = $RDData.BrokenConnectionAction
UserGroup = $RDData.UserGroup
DependsOn = '[xRDSessionCollection]collection'
PsDscRunAsCredential = $domainadmin
}
 
xRDLicenseConfiguration licenseconfig {
 
ConnectionBroker = $RDData.ConnectionBroker
LicenseServer = $RDData.LicenseServer
LicenseMode = $RDData.LicenseMode
DependsOn = '[xRDSessionCollectionConfiguration]collectionconfig'
PsDscRunAsCredential = $domainadmin
}
 
}
 
Node $AllNodes.Where{$_.Role -eq 'Session Host'}.NodeName {
 
WindowsFeature SessionHost {
 
Name = 'RDS-RD-Server'
Ensure = 'Present'
}
 
}
 
Node $AllNodes.Where{$_.Role -eq 'Web Access'}.NodeName {
 
WindowsFeature WebAccess {
 
Name = 'RDS-Web-Access'
Ensure = 'Present'
}
}
}
 
RDS -OutputPath 'C:\DSC Configuration' -domainadmin $domainadmin -ConfigurationData $data -Verbose