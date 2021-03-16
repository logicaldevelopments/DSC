xRDRemoteApp chrome {
 
CollectionName = $RDData.CollectionName
Alias = 'Chrome'
DisplayName = 'Chrome'
FilePath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
DependsOn = '[xRDLicenseConfiguration]licenseconfig'
PsDscRunAsCredential = $domainadmin
}