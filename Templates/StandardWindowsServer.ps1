configuration StandardWindowsServer {

    Node DC01 { # Name of the server managed by the configuration file

        # Roles and Features Section - Remove or Add features below to customize server roles

        File Progress01 {
            DestinationPath = 'C:\DSC\Config-Started.txt'
            Contents = 'Windows Server Configuration Started'
            Type = 'File'
            Ensure = 'Present'
        }  

            
        # Web server role:        
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

        File WebServer {
            DestinationPath = 'C:\DSC\WebServer-Installed.txt'
            Contents = 'IIS Installation completed'
            Type = 'File'
            Ensure = 'Present'
        }


        # DHCP server role:        
        WindowsFeature DHCP {
            Name = 'DHCP'
            Ensure = 'Present'
        }
        
        File DHCP {
            DestinationPath = 'C:\DSC\DHCPServer-Installed.txt'
            Contents = 'DHCP Service Installation Completed'
            Type = 'File'
            Ensure = 'Present'
        }


        # Hyper-V server role:        
        WindowsFeature DHCP {
            Name = 'Hyper-V'
            Ensure = 'Present'
        }
        
        File HyperV {
            DestinationPath = 'C:\DSC\Hyper-V-Server-Installed.txt'
            Contents = 'Hyper-V Server role installed '
            Type = 'File'
            Ensure = 'Present'
        }


        # Active Directory Domain Services:        
        WindowsFeature AD DS {
            Name = 'AD-Domain-Services'
            Ensure = 'Present'
        }
        
        File ADDS {
            DestinationPath = 'C:\DSC\ADDS-Server-Installed.txt'
            Contents = 'AD DS Server server role installed'
            Type = 'File'
            Ensure = 'Present'
        }



    } 

} #configuration

StandardWebServer -OutputPath C:\DSC -Verbose