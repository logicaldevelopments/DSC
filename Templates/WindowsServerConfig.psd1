### Begin Data Section ###
### Use this section to inform the servers names and roles ###

# Copy and past the roles names below to match the exact information:  
# Role = "LAN Server", "RDS Server", "Domain Controller", "DHCP Server", "DNS Server", "Print Server", "Host Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server"

@{
    AllNodes = @(

       
        @{
            NodeName = "AVM-Test"
            Role = "LAN Server", "RDS Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server", "Domain Controller", "DHCP Server", "DNS Server", "Print Server"
        },

        @{
            NodeName = "AVPX-120"
            Role = "Application Server"
        }

        # @{
        #     NodeName         = "ServerName"
        #     Role             = "RoleName"
        # }


    )
    
}

### End Data Section ###
