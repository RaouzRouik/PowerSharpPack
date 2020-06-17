function Invoke-Snaffler
{
    
    [CmdletBinding()]
    Param (
        [String]
        $Command = "-u -s -o .\snaffler.txt"

    )

    [int]$systemRoleID = $(get-wmiObject -Class Win32_ComputerSystem).DomainRole



         $systemRoles = @{
                              0         =    " Standalone Workstation    " ;
                              1         =    " Member Workstation        " ;
                              2         =    " Standalone Server         " ;
                              3         =    " Member Server             " ;
                              4         =    " Backup  Domain Controller " ;
                              5         =    " Primary Domain Controller "       
         }
    $systemRoleID = $(get-wmiObject -Class Win32_ComputerSystem).DomainRole
        
    if($systemRoleID -ne 1){
        
            "       [-] This script needs access to the domain. They can only be run on a domain member machine.`n"
            return
                                            
    }
    $RAS = [System.Reflection.Assembly]::Load([Convert]::FromBase64String($base64binary))
    
    $OldConsoleOut = [Console]::Out
    $StringWriter = New-Object IO.StringWriter
    [Console]::SetOut($StringWriter)

    [Snaffler.Snaffler]::Main($Command.Split(" "))

    [Console]::SetOut($OldConsoleOut)
    $Results = $StringWriter.ToString()
    $Results

}