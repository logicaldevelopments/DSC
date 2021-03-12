configuration StandardWebServer {

    Node isPresent {

        WindowsFeature WebServer {
            Name = 'Web-Server'
            Ensure = 'Present'
        }

        File Helloworld {
            DestinationPath = 'C:\inetpub\wwwroot\Helloworld.html'
            Contents = 'Hello World'
            Type = 'File'
            Ensure = 'Present'
            DependsOn = '[WindowsFeature]WebServer'

        }


    } #Node



    Node isNotPresent {

        WindowsFeature WebServer {
            Name = 'Web-Server'
            Ensure = 'Absent'
        }

        File NotWeb {
            DestinationPath = 'C:\DSC\NotWebServer.txt'
            Contents = 'Hello World'
            Type = 'File'
            Ensure = 'Present'

        }


    } #Node

} #configuration

StandardWebServer -OutputPath C:\DSC -Verbose