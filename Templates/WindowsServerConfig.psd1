### Begin Data Section ###
### Use this section to inform the servers names and roles ###

# Copy and past the roles names below to match the exact information:  
# Role = "LAN Server", "RDS Server", "Domain Controller", "DHCP Server", "DNS Server", "Print Server", "Host Server", "Cloud BU", "SQL Server", "Exchange Server", "SQL Server", "Application Server", "Web Server", "Print Server"

@{
    AllNodes = @(

       
        @{
            NodeName = "AVM-DSC"
            Role = "Application Server", "Web Server", "Print Server", "DHCP Server", "DNS Server", "Print Server"
        }

        # @{
        #     NodeName = "AVM-Test03"
        #     Role = "Application Server"
        # }

        # @{
        #     NodeName         = "ServerName"
        #     Role             = "RoleName"
        # }


    )
    
}

### End Data Section ###
