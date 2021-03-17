

# Roles names we have been using: 
# Role = "LAN Server", "RDS Server", "Domain Controller", "DHCP Server", "DNS Server", "Print Server", "Host Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server"

@{
    AllNodes = @(

       
        @{
            NodeName = "WindowsServer"
            Role = "LAN Server", "RDS Server", "Domain Controller", "DHCP Server", "DNS Server", "Print Server", "Host Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server"
        }

        # @{
        #     NodeName        = "ServerName"
        #     Role            = "RoleName", "RoleName"
        # },

        # @{
        #     NodeName         = "ServerName"
        #     Role             = "RoleName"
        # }


    )
    
}