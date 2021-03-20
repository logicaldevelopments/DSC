### Begin Data Section ###
### Use this section to inform the servers names and roles ###

# Copy and past the roles names below to match the exact information:  
# Role = "LAN Server", "RDS Server", "Domain Controller", "DHCP Server", "DNS Server", "Print Server", "Host Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server"

@{
    AllNodes = @(

       
        @{
            NodeName = "AVM-Randy"
            Role = "Application Server", "Web Server", "Print Server", "DHCP Server", "DNS Server", "Print Server"
        },

        @{
            NodeName = "AVM-Test"
            Role = "Application Server", "Domain Controller"
        }

        # @{
        #     NodeName         = "ServerName"
        #     Role             = "RoleName", "Domain Controller"
        # }


    )
    
}

### End Data Section ###
