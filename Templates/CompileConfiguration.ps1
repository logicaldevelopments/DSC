$ConfigDataFile = Import-PowerShellDataFile WindowsServerConfig.psd1
$automationAccountName = "ROB-AI"
$resourceGroupName = "RG-AA-ROB-AI"
$configurationName = "WindowsServer"
$pathToConfiguration = "C:\Users\junio\OneDrive - Logical Developments\Azure\GitHub\DSC\Templates\WindowsServer\AVM-Test.mof"

#copy $pathToConfiguration c:\Windows\System32
 
#Import-AzAutomationDscConfiguration -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName -SourcePath $pathToConfiguration -Force -Published
 
#Start-AzAutomationDscCompilationJob -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName -ConfigurationName $configurationName -ConfigurationData $ConfigData



#Get-AzAutomationDscConfiguration -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName -ConfigurationName $configurationName


Import-AzAutomationDscConfiguration -AutomationAccountName "ROB-AI" -ResourceGroupName "RG-AA-ROB-AI" -SourcePath "C:\Users\junio\OneDrive - Logical Developments\Azure\GitHub\DSC\Templates\WindowsServer\WindowsServer.mof" -Force -Published





