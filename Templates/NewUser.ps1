configuration NewUser {

    Node localhost {

        User Helio #ResourceName
{
    UserName = 'helio'
    Description = 'Administrative User'
    Disabled = 0
    Ensure = 'Present'
    FullName = 'Helio Pereira'
    Password = [PSCredential]$MyCred
    PasswordChangeRequired = 0
    PasswordNeverExpires = 0
}


    }

    
}

NewUser -OutputPath c:\SysAdm -Verbose