### Begin Data Section ###
### Use this section to inform the servers names and roles ###

# Copy and past the roles names below to match the exact information:  
# Role = "LAN Server", "RDS Server", "Domain Controller", "DHCP Server", "DNS Server", "Print Server", "Host Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server"

$MyData=
@{
    AllNodes = @(

       
        @{
            NodeName = "AVM-Test"
            Role = "LAN Server", "RDS Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server"
        },

        @{
            NodeName        = "AVM-Test02"
            Role            = "Domain Controller", "DHCP Server", "DNS Server", "Print Server"
        }

        # @{
        #     NodeName         = "ServerName"
        #     Role             = "RoleName"
        # }


    )
    
}

### End Data Section ###


### Begin Configuration Section ###

configuration WindowsServer {

    Import-DscResource -Module PSDesiredStateConfiguration
    Import-DscResource -Module ComputerManagementDsc
    Import-DscResource -Module UpdateServicesDsc
    Import-DscResource -Module NetworkingDsc



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


    # Remote Desktop Server role:
    Node $AllNodes.Where{$_.Role -contains "RDS Server"}.NodeName {        
        WindowsFeature RDSServer {
            Name = 'Remote-Desktop-Services'
            Ensure = 'Present'
        }

        # Limit sessions from the same user to 3 on RDS server
        Registry RDSLimitSession {
            Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server'
            ValueName = 'IdleWinStationPoolCount'
            Ensure = 'Present'
            ValueData = '3'
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

        # Set ESC of Internet Explorer
        IEEnhancedSecurityConfiguration IEUsers {
            Enabled = 1
            Role = 'Users'
            SuppressRestart = 1
        }

        IEEnhancedSecurityConfiguration IEAdmins {
            Enabled = 0
            Role = 'Administrators'
            SuppressRestart = 1
        }


        # Disable Admin Approval Mode on UAC
        UserAccountControl UACConfig {
            IsSingleInstance = 'Yes'
            ConsentPromptBehaviorAdmin = 0
            ConsentPromptBehaviorUser = 1
            
        }
               
            
            
        # Enable Remote Desktop Connection
        RemoteDesktopAdmin EnableRDP {
            IsSingleInstance = 'Yes'
            Ensure = 'Present'
            UserAuthentication = 'NonSecure'
        }

        # RDS Disable single session per user
        Registry RDSSingleSession {
            Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server'
            ValueName = 'fSingleSessionPerUser'
            Ensure = 'Present'
            ValueData = '0'
        }


        # Windows Updates - Disable Automatic Installation
        Registry WUAUDisableAutoInstall {
            Key = 'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU'
            ValueName = 'NoAutoUpdate'
            Ensure = 'Present'
            ValueData = '1'
        }

        # Windows Firewall Rules      

        Firewall EnableADDS {
            Name = 'Active Directory Domain Services'
            Enabled = 'True'
        }

        Firewall EnableADWeb {
            Name = 'Active Directory Web Services'
            Enabled = 'True'
        }


        Firewall EnableCorenet {
            Name = 'Core Networking'
            Enabled = 'True'
        }

        Firewall EnableCortana {
            Name = 'Cortana'
            Enabled = 'True'
        }

        Firewall EnableDFSM {
            Name = 'DFS Management'
            Enabled = 'True'
        }

        Firewall EnableDFSRep {
            Name = 'DFS Replication'
            Enabled = 'True'
        }

        Firewall EnableDHCPRelay {
            Name = 'DHCP Relay Agent'
            Enabled = 'True'
        }

        Firewall EnableDHCPServer {
            Name = 'DHCP Server'
            Enabled = 'True'
        }

        Firewall EnableDHCPManagement {
            Name = 'DHCP Server Management'
            Enabled = 'True'
        }

        Firewall EnableDHCP6 {
            Name = 'DHCPv6 Relay Agent'
            Enabled = 'True'
        }

        Firewall EnableDiagnostics {
            Name = 'DiagTrack'
            Enabled = 'True'
        }

        Firewall EnableRRAS {
            Name = 'Dial Protocol Server'
            Enabled = 'True'
        }

        Firewall EnableDNSServer {
            Name = 'DNS Service'
            Enabled = 'True'
        }


        Firewall EnableEmails {
            Name = 'eMail and Accounts'
            Enabled = 'True'
        }

        Firewall EnableDFRS {
            Name = 'File Replication'
            Enabled = 'True'
        }

        Firewall EnableFSManagement {
            Name = 'File Server Remote Management'
            Enabled = 'True'
        }

        Firewall EnableFSSharing {
            Name = 'File and Printer Sharing'
            Enabled = 'True'
        }

        Firewall EnableHyperV {
            Name = 'Hyper-V'
            Enabled = 'True'
        }

        Firewall EnableHyperVManagement {
            Name = 'Hyper-V Management Clients'
            Enabled = 'True'
        }

        Firewall EnableKerberos {
            Name = 'Kerberos Key Distribution Service'
            Enabled = 'True'
        }

        Firewall EnableNetDiscovery {
            Name = 'Network Discovery'
            Enabled = 'True'
        }

        Firewall EnableNetLogon {
            Name = 'Netlogon Service'
            Enabled = 'True'
        }

        Firewall EnablePerfmon {
            Name = 'Performance Logs and Alerts'
            Enabled = 'True'
        }

        Firewall EnableRemoteAccess {
            Name = 'Remote Access'
            Enabled = 'True'
        }

        Firewall EnableRAQuarantine {
            Name = 'Remote Access Quarantine'
            Enabled = 'True'
        }

        Firewall EnableRemoteAdm {
            Name = 'Remote Administration'
            Enabled = 'True'
        }

        Firewall EnableRemoteDesktop {
            Name = 'Remote Desktop'
            Enabled = 'True'
        }

        Firewall EnableRemoteEventLog {
            Name = 'Remote Event Log Management'
            Enabled = 'True'
        }

        Firewall EnableRemoteEventMonitor {
            Name = 'Remote Event Monitor'
            Enabled = 'True'
        }

        Firewall EnableRemoteScheduledTasks {
            Name = 'Remote Scheduled Tasks Management'
            Enabled = 'True'
        }

        Firewall EnableRemoveServiceMgt {
            Name = 'Remote Service Management'
            Enabled = 'True'
        }

        Firewall EnableRemoteShutdown {
            Name = 'Remote Shutdown'
            Enabled = 'True'
        }

        Firewall EnableRemoteVolumeMgt {
            Name = 'Remote Volume Management'
            Enabled = 'True'
        }

        Firewall EnableRRASS {
            Name = 'Routing and Remote Access'
            Enabled = 'True'
        }

        Firewall EnableSSTP {
            Name = 'Secure Socket Tunneling Protocol'
            Enabled = 'True'
        }

        Firewall EnableHTTP {
            Name = 'Secure World Wide Web Services (HTTPS)'
            Enabled = 'True'
        }

        Firewall EnableSmartScreen {
            Name = 'SmartScreen'
            Enabled = 'True'
        }

        Firewall EnableVMMonitoring {
            Name = 'Virtual Machine Monitoring'
            Enabled = 'True'
        }

        Firewall EnableWFRM {
            Name = 'Windows Firewall Remote Management'
            Enabled = 'True'
        }

        Firewall EnableWRM {
            Name = 'Windows Remote Management'
            Enabled = 'True'
        }

        Firewall EnableWRMI {
            Name = 'Windows Remote Management Instrumentation (WMI)'
            Enabled = 'True'
        }

        Firewall EnableWRMC {
            Name = 'Windows Remote Management (Compatibility)'
            Enabled = 'True'
        }

        Firewall EnableWB {
            Name = 'Windows Backup'
            Enabled = 'True'
        }

        Firewall EnableWDLS {
            Name = 'Windows Default Lock Screen'
            Enabled = 'True'
        }

        Firewall EnableWSE {
            Name = 'Windows Shell Experience'
            Enabled = 'True'
        }

        Firewall EnableWSA {
            Name = 'Work or School Account'
            Enabled = 'True'
        }

        Firewall EnableWWWS {
            Name = 'World Wide web Services (HTTP)'
            Enabled = 'True'
        }

        Firewall EnableYA {
            Name = 'Your Account'
            Enabled = 'True'
        }



        # Disable Automatic Restart on Crashes
        Registry DisableAutoRestart {
            Key = 'HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\CrashControl'
            ValueName = 'AutoReboot'
            Ensure = 'Present'
            ValueData = '0'
        }


        # Report the configuration job is complete
        File Progress01 {
            DestinationPath = 'C:\DSC\ServerConfig-Complete.txt'
            Contents = 'Windows Server Configuration is complete, please check the status on Azure'
            Type = 'File'
            Ensure = 'Present'
        }   

    }



    

}

### End Configuration Section ###


WindowsServer -ConfigurationData $MyData