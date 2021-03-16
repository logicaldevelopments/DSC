
configuration WindowsServer {

    Import-DscResource -Module PSDesiredStateConfiguration
    Import-DscResource -Module ComputerManagementDsc



    ### Starting Role Based Section ###
    # Role Based Section: Install and configure roles based in the content of the Role field specified in the configuration file

    # Web server role:
     Node $AllNodes.Where{$_.Role -contains "Web Server"}.NodeName {    
      
        WindowsFeature WebServer {
            Name = 'Web-Server'
            Ensure = 'Present'
        }
        
        File Helloworld {
            DestinationPath = 'C:\inetpub\wwwroot\Helloworld.html'
            Contents = 'Helloworld'
            Type = 'File'
            Ensure = 'Present'
        }
    }


    
    # DHCP server role:
    Node $AllNodes.Where{$_.Role -contains "DHCP Server"}.NodeName {       
        WindowsFeature DHCP {
            Name = 'DHCP'
            Ensure = 'Present'
        }
    }
        





    # Hyper-V server role:       
    Node $AllNodes.Where{$_.Role -contains "Host Server"}.NodeName { 
        WindowsFeature HyperV {
            Name = 'Hyper-V'
            Ensure = 'Present'
        }
    }    
        




    # Active Directory Domain Services role: 
    Node $AllNodes.Where{$_.Role -contains "Domain Controller"}.NodeName {       
        WindowsFeature ADDS {
            Name = 'AD-Domain-Services'
            Ensure = 'Present'
        }
        
    }


        

    # File and Storage Server role, LAN Server, LANWin Server: 
    Node $AllNodes.Where{$_.Role -contains "LAN Server"}.NodeName {       
        WindowsFeature File-Server {
            Name = 'FileAndStorage-Services'
            Ensure = 'Present'
        }
        
    }



    # Print Server role:
    Node $AllNodes.Where{$_.Role -contains "Print Server"}.NodeName {        
        WindowsFeature PrintServices {
            Name = 'Print-Services'
            Ensure = 'Present'
        }
    }    
        
    
    ### Ending Role Based Section ###

    

    ### Starting Default Configuration Settings ###    
    # Default Windows Configurations settings: Those settings are standard and applied to every server:
    
    
    Node $AllNodes.NodeName {
        
        # Set timezone to PST
        TimeZone TimePST {
            IsSingleInstance = "Yes"
            TimeZone = 'Pacific Standard Time'            
        }

        
        # Report the configuration job is complete
        File Progress01 {
            DestinationPath = 'C:\DSC\ServerConfig-Complete.txt'
            Contents = 'Windows Server Configuration is complete, please check the status on Azure'
            Type = 'File'
            Ensure = 'Present'
            }     


    }



    

} #configuration

WindowsServer -ConfigurationData WindowsServerConfig.psd1