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
        # WindowsFeature HyperV {
        #     Name = 'Hyper-V'
        #     Ensure = 'Present'
        # }
        
        # File HyperV {
        #     DestinationPath = 'C:\DSC\Hyper-V-Server-Installed.txt'
        #     Contents = 'Hyper-V Server role installed '
        #     Type = 'File'
        #     Ensure = 'Present'
        # }




        # Active Directory Domain Services role:        
        WindowsFeature ADDS {
            Name = 'AD-Domain-Services'
            Ensure = 'Present'
        }
        
        File ADDSserver {
            DestinationPath = 'C:\DSC\ADDS-Server-Installed.txt'
            Contents = 'AD DS Server role installed'
            Type = 'File'
            Ensure = 'Present'
        }


        

        # File and Storage Server role:        
        WindowsFeature File-Server {
            Name = 'FileAndStorage-Services'
            Ensure = 'Present'
        }
        
        File FileStor {
            DestinationPath = 'C:\DSC\File-Server-Installed.txt'
            Contents = 'File and Storage Server role installed'
            Type = 'File'
            Ensure = 'Present'
        }




        # Print Server role:        
        WindowsFeature PrintServices {
            Name = 'Print-Services'
            Ensure = 'Present'
        }
        
        File PrintS {
            DestinationPath = 'C:\DSC\Print-Server-Installed.txt'
            Contents = 'Print Server role installed'
            Type = 'File'
            Ensure = 'Present'
        }



        # Windows Configurations settings - Those settings below are usually standard and applied to every server

        # Set timezone to PST
        xTimeZone TimePST {
            TimeZone = 'Pacific Standard Time'            
        }

        File TimeZ {
            DestinationPath = 'C:\DSC\Timezone-Set-to-PST.txt'
            Contents = 'Timezone Set'
            Type = 'File'
            Ensure = 'Present'
        }



    } 

} #configuration

StandardWindowsServer -OutputPath C:\DSC -Verbose