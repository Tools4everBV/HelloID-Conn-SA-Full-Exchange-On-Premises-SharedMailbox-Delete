# HelloID-Conn-SA-Full-Exchange-On-Premises-SharedMailboxDelete

| :information_source: Information |
| :------------------------------- |
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as Exchange connection URI, admin credentials, etc. You might need to coordinate with the client's Exchange administrator before implementing this connector. |

## Description

HelloID-Conn-SA-Full-Exchange-On-Premises-SharedMailboxDelete is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can delete a shared mailbox in Exchange On-Premises. The following options are available:

1. Search and select a shared mailbox (wildcard search by name, alias, display name, primary SMTP address, and email addresses)
2. Delete the selected shared mailbox

## Getting started

### Requirements

#### Exchange On-Premises Setup

Before implementing this connector, make sure you have the following in place:

* **Exchange Server PowerShell Remoting** enabled
  * The Exchange server must have PowerShell remoting configured
  * The connection URI should be accessible from the HelloID agent
* **Admin Credentials**
  * A service account with Exchange admin permissions
  * The account must have rights to delete shared mailboxes
* **Network Connectivity**
  * The HelloID agent must be able to reach the Exchange server on the PowerShell remoting port (typically HTTPS port 443)

#### HelloID-specific configuration

Once you have the Exchange environment ready, configure the following HelloID-specific requirements:

* **Exchange Permissions**
  * The service account needs permissions to:
    * View shared mailboxes (`Get-Mailbox`)
    * Delete shared mailboxes (`Remove-Mailbox`)
* **Connection Settings**
  * Exchange Connection URI (e.g., `https://exchange.domain.com/PowerShell`)
  * Admin username (e.g., `svc-helloid@domain.com`)
  * Admin password (stored securely in HelloID)

### Connection settings

The following global variables must be configured in HelloID when importing and configuring the delegated form:

| Variable | Description | Mandatory |
| -------- | ----------- | --------- |
| ExchangeConnectionUri | The URI to connect to Exchange On-Premises (e.g., https://exchange.domain.com/PowerShell) | Yes |
| ExchangeAdminUsername | The username for Exchange admin account | Yes |
| ExchangeAdminPassword | The password for Exchange admin account | Yes |

## Remarks

### Mailbox Search and Deletion

#### Shared Mailbox Search Process

The form includes a search field that retrieves matching shared mailboxes using Exchange On-Premises cmdlets:

1. Search Mailboxes (`Get-Mailbox` cmdlet)
   * Mailbox type: Filters by `RecipientTypeDetails = SharedMailbox`
   * Search criteria: Matches against `Name`, `Alias`, `PrimarySmtpAddress`, and `DisplayName`
   * Wildcard support: Uses wildcard matching to find partial matches
   * Returns a list of shared mailboxes for selection

#### Shared Mailbox Deletion Process

When the form is submitted, the following process occurs in Exchange On-Premises:

1. Delete Mailbox (`Remove-Mailbox` cmdlet)
   * The script removes the selected shared mailbox using `Remove-Mailbox` with the `Confirm:$false` parameter
   * The mailbox and all associated data are permanently deleted from Exchange On-Premises
   * No data recovery is possible after deletion

## Development resourcesDisplayName`, `PrimarySmtpAddress`, and `EmailAddresses

### PowerShell Cmdlets

The following PowerShell cmdlets are used by the connector:

| Cmdlet | Description |
| ------ | ----------- |
| New-PSSession | Create a remote PowerShell session to Exchange On-Premises |
| Import-PSSession | Import cmdlets from the remote Exchange session |
| Get-Mailbox | Search and retrieve mailboxes to find shared mailboxes |
| Remove-Mailbox | Delete a shared mailbox |
| Remove-PSSession | Close the Exchange PowerShell session |

### Documentation

For more information on the PowerShell cmdlets used in this connector, please refer to:

Exchange On-Premises PowerShell:

* [Connect to Exchange servers using remote PowerShell](https://learn.microsoft.com/en-us/powershell/exchange/connect-to-exchange-servers-using-remote-powershell)
* [Get-Mailbox](https://learn.microsoft.com/en-us/powershell/module/exchange/get-mailbox)
* [Remove-Mailbox](https://learn.microsoft.com/en-us/powershell/module/exchange/remove-mailbox)
* [New-PSSession](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-pssession)
* [Remove-PSSession](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/remove-pssession)

## Getting help

💡 **Tip:** For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages.

## HelloID docs

The official HelloID documentation can be found at: [https://docs.helloid.com/](https://docs.helloid.com/)
_If you need help, feel free to ask questions on our [TODO-forum](https://forum.helloid.com/forum/helloid-connectors/service-automation/0000-helloid-sa-exchange-on-premises-delete-sharedmailbox)_

## HelloID Docs
The official HelloID documentation can be found at: https://docs.helloid.com/