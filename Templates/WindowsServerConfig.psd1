

# Roles names we have been using: 
# Role = "LAN Server", "RDS Server", "DC", "DHCP", "DNS", "Print Server", "Host Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server"

@{
    AllNodes = @(

       
        @{
            NodeName = "ServerName"
            Role = "RoleName"
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