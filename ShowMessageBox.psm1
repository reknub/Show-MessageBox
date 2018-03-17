<#

.Synopsis
   Displays a Windows Form MessageBox

.DESCRIPTION
   A CMDlet to Display a Windows Forms MessageBox in Powershell Scripts

.EXAMPLE
   Show-MessageBox -Message "Failed to establish Remote PowerShell Session with $Variable" -Title "Failed to Connect" -TypeOfMessageBox OK
   
   Description
   -----------
   Displays a message box with message, title and OK button

.EXAMPLE
    if ((Show-MessageBox -Message "Delete All Users?" -Title "Delete All" -TypeOfMessageBox "YesNo") -eq "Yes") {...}

    Description
    -----------
    Displays a message box with Yes and No buttons, if the user clicks Yes the code block {...} is executed

.NOTES
   Author: Richard Bunker
   Version History:-
   1.0 - 25/02/2016 - Richard Bunker - Initial Version
   1.1 - 03/05/2016 - Richard Bunker - Added support for displaying icons: Information, Warning, Question and Error
   1.2 - 08/06/2016 - Richard Bunker - Added 'None' as option for TypeOfIcon and made all arguments optional except for Message
   1.3 - 25/08/2016 - Richard Bunker - Corrected output, now only outputs user response such as Yes, No, Abort etc

.FUNCTIONALITY
   Enables the use of Windows Form MessageBoxes in PowerShell

#>

$Script:ErrorActionPreference = "Stop"

function Show-MessageBox {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [String]
        $Message,
        [Parameter(Mandatory=$false, Position=1)]
        [String]
        $Title="",
        [Parameter(Mandatory=$false, Position=2)]
        [ValidateSet("OK","OkCancel","AbortRetryIgnore","YesNoCancel","YesNo","RetryCancel")]
        [String]
        $TypeOfMessageBox="OK",
        [Parameter(Mandatory=$false, Position=3)]
        [ValidateSet("None", "Information","Question","Warning","Error")]
        [String]
        $TypeOfIcon="None"
    )
    
    # Convert string of MessageBox type to integer for show message command
    switch ($TypeOfMessageBox)
    {
        'OK' {$iType=0}
        'OkCancel' {$iType=1}
        'AbortRetryIgnore' {$iType=2}
        'YesNoCancel' {$iType=3}
        'YesNo' {$iType=4}
        'RetryCancel' {$iType=5}
    }

    # Display Windows Message Box from PowerShell
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.MessageBox]::Show($Message, $Title, $iType, $TypeOfIcon)
    
}

# Export Module Functions:
Export-ModuleMember -Function Show-MessageBox