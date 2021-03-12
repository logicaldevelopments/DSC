[DSCLocalConfigurationManager()]

configuration LCM {

    param (
 
        [parameter(Mandatory=$true)]
        [string[]]$computername
 
    )

    node $computername {

        settings {

            RebootNodeIfNeeded = $true
            ConfigurationMode = 'Applyonly'
            ActionAfterReboot = ‘ContinueConfiguration’


        }

    }

}

$computername = 'RDCB01','RDSH01','RDWA01'

LCM -OutputPath 'C:\DSC' -computername $computername -verbose