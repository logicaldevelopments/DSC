function Merge-Hashtables
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [Hashtable]
        $First,
 
        [Parameter(Mandatory=$true)]
        [Hashtable]
        $Second
    )
 
    function ProcessKeys($first, $second)
    {
        foreach ($key in $second.Keys) {
            $firstValue = $first[$key]
            $secondValue = $second[$key]
 
            if ($firstValue -is [hashtable] -and $secondValue -is [hashtable])
            {
                ProcessKey($firstValue, $secondValue)
            }
            else
            {
                $first[$key] = $secondValue
            }
        }
    }
 
    $firstClone = $First.Clone()
    $secondClone = $Second.Clone()
 
    ProcessKeys -first $firstClone -second $secondClone
 
    return $firstClone
}


$sharedConfigData = Import-PowerShellDataFile MySampleConfiguration.shared.psd1
$azureCloudConfigData = Import-PowerShellDataFile MySampleConfiguration.AzureCloud.psd1
$mergedConfigurationData = Merge-Hashtables -First $sharedConfigData -Second $azureConfigData
 
$automationAccountName = "Your Azure Automation Account Name"
$resourceGroupName = "The resource group containing your automation account"
$configurationName = "Name of your configuration"
$pathToConfiguration = "Path to your DSC file"
 
Import-AzAutomationDscConfiguration -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName -SourcePath $pathToConfiguration -Force -Published
 
Start-AzAutomationDscCompilationJob -AutomationAccountName $automationAccountName -ResourceGroupName $resourceGroupName -ConfigurationName $configurationName -ConfigurationData $mergedConfigurationData
