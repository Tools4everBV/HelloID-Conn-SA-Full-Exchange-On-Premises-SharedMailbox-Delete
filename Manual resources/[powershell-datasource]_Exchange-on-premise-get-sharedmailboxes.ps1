# Variables configured in form
$searchValue = $datasource.searchValue
if ([string]::IsNullOrWhiteSpace($searchValue)) {
    # Return empty result if no search value is provided
    return
}

# Build search query with wildcard
$searchQuery = "*$searchValue*"

# Global variables
# Outcommented as these are set from Global Variables
# $ExchangeConnectionUri = ""
# $ExchangeAdminUsername = ""
# $ExchangeAdminPassword = ""

# Fixed values
# Properties to select - Select only needed properties to limit memory usage and speed up processing
$propertiesToSelect = @(
    "Guid"
    , "DisplayName"
    , "Name"
    , "Alias"
    , "PrimarySmtpAddress"
    , "UserPrincipalName"
    , "RecipientTypeDetails"
)

# Enable TLS1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

# Set debug logging
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

#region functions
#endregion functions

try {
    # Create credentials
    $actionMessage = "creating credentials object"
    
    $securePassword = ConvertTo-SecureString -String $ExchangeAdminPassword -AsPlainText -Force
    $credential = [System.Management.Automation.PSCredential]::new($ExchangeAdminUsername, $securePassword)
    
    Write-Information "Created credentials for user [$ExchangeAdminUsername]"

    # Connect to Exchange On-Premise
    # Docs: https://learn.microsoft.com/en-us/powershell/exchange/connect-to-exchange-servers-using-remote-powershell
    $actionMessage = "connecting to Exchange On-Premise"

    $sessionOptionParams = @{
        SkipCACheck         = $false
        SkipCNCheck         = $false
        SkipRevocationCheck = $false
    }

    $sessionOption = New-PSSessionOption @sessionOptionParams

    $sessionParams = @{
        Authentication    = 'Default'
        ConfigurationName = 'Microsoft.Exchange'
        ConnectionUri     = $ExchangeConnectionUri
        Credential        = $credential
        SessionOption     = $sessionOption
        ErrorAction       = "Stop"
    }

    $exchangeSession = New-PSSession @sessionParams
    $null = Import-PSSession -Session $exchangeSession -DisableNameChecking -AllowClobber -CommandName "Get-Mailbox" -ErrorAction Stop
    
    Write-Information "Successfully connected to Exchange using URI [$ExchangeConnectionUri]"

    # Get Mailboxes
    # Docs: https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailbox
    $actionMessage = "querying shared mailboxes that match search query [$searchQuery]"

    # Build filter for Get-Mailbox
    # Note: Exchange On-Premise uses different filter syntax than Exchange Online
    $filter = "RecipientTypeDetails -eq 'SharedMailbox' -and (Alias -like '$searchQuery' -or Name -like '$searchQuery' -or PrimarySmtpAddress -like '$searchQuery' -or DisplayName -like '$searchQuery')"

    $getMailboxesSplatParams = @{
        Filter      = $filter
        ResultSize  = "Unlimited"
        ErrorAction = 'Stop'
    }

    $mailboxes = Get-Mailbox @getMailboxesSplatParams | Select-Object -Property $propertiesToSelect
    Write-Information "Queried shared mailboxes that match search query [$searchQuery]. Result count: $(($mailboxes | Measure-Object).Count)"

    # Sort and send results to HelloID
    $actionMessage = "sending results to HelloID"
    $mailboxes | Sort-Object -Property DisplayName | ForEach-Object {
        Write-Output $_
    }
}
catch {
    $ex = $PSItem
    if (-not [string]::IsNullOrEmpty($ex.Exception.Message)) {
        $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
        $auditMessage = "Error $($actionMessage). Error: $($ex.Exception.Message)"
    }
    else {
        $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception)"
        $auditMessage = "Error $($actionMessage). Error: $($ex.Exception)"
    }
    Write-Warning $warningMessage
    Write-Error $auditMessage
    # exit # use when using multiple try/catch and the script must stop
}
finally {
    # Disconnect from Exchange
    # Docs: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/remove-pssession
    if ($null -ne $exchangeSession) {
        $deleteExchangeSessionSplatParams = @{
            Session     = $exchangeSession
            Confirm     = $false
            ErrorAction = "Stop"
        }
        $null = Remove-PSSession @deleteExchangeSessionSplatParams
        Write-Information "Successfully disconnected from Exchange using URI [$ExchangeConnectionUri]"
    }
}
