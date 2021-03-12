Configuration IIS {

    Node localhost {

        WindowsFeature IIS {
        Name = web-server
        Ensure = Present
        LogPath = c:\SysAdm\iis.txt

        } #WindowsFeature

    } #Node
} #configuration

IIS -OutputPath c:\SysAdm\ -Verbose