$data = @{

    AllNodes = @(

        
        @{

            NodeName = '*'
            PSDscAllowPlainTextPassword = $true
        },
     
       
    
        @{

            NodeName = 'localhost'
            Role = 'Application Server'
        },

        @{

            NodeName = 'localhost2'
            Role = 'Application Server'
        },

        @{

            NodeName = 'localhost3'
            Role = 'Application Server'
        },
              


    );

    NonNodeData = @{


    }


}