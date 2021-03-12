configuration StandardWebServer {

    Node AVMTest2 {

        WindowsFeature WebServer {
            Name = web-server
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

} #configuration

StandardWebServer -OutputPath C:\Configs

Start-DsConfiguration C:\Configs -Wait -Verbose