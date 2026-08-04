## Description

HelloID-Conn-SA-Full-Exchange-On-Premise-SharedMailboxDelete is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can delete a shared mailbox in Exchange On-Premise. The following options are available:

1. Search and select a shared mailbox (wildcard search by name, alias, email addresses, and display name)
2. Delete the selected shared mailbox

## Versioning
| Version | Description | Date |
| - | - | - |
| 2.0.0   | Updated to latest best practices | 2026/08/04 |
| 1.0.0   | Initial release | 2023/08/18 |

<!-- TABLE OF CONTENTS -->
## Table of Contents
* [Description](#description)
* [All-in-one PowerShell setup script](#all-in-one-powershell-setup-script)
  * [Getting started](#getting-started)
* [Post-setup configuration](#post-setup-configuration)
* [Manual resources](#manual-resources)


## All-in-one PowerShell setup script
The PowerShell script "createform.ps1" contains a complete PowerShell script using the HelloID API to create the complete Form including user defined variables, tasks and data sources.

 _Please note that this script asumes none of the required resources do exists within HelloID. The script does not contain versioning or source control_


### Getting started
Please follow the documentation steps on [HelloID Docs](https://docs.helloid.com/hc/en-us/articles/360017556559-Service-automation-GitHub-resources) in order to setup and run the All-in one Powershell Script in your own environment.


## Post-setup configuration
After the all-in-one PowerShell script has run and created all the required resources, the following items need to be configured according to your own environment:

### Connection settings

The following global variables must be configured in HelloID when importing and configuring the delegated form:

| Variable | Description | Example | Mandatory |
| -------- | ----------- | ------- | --------- |
| ExchangeConnectionUri | The URI to connect to Exchange On-Premise | https://exchangeserver.domain.com/PowerShell | Yes |
| ExchangeAdminUsername | The username for Exchange admin account | admin@domain.com | Yes |
| ExchangeAdminPassword | The password for Exchange admin account | ******** | Yes |

## Manual resources
This Delegated Form uses the following resources in order to run:

### PowerShell data source
**[powershell-datasource]_Exchange-on-premise-get-sharedmailboxes.ps1**

This PowerShell data source searches for shared mailboxes in Exchange On-Premise based on the user's search input. It supports wildcard search across mailbox properties (Name, Alias, DisplayName, PrimarySmtpAddress).

### Delegated form task
**[Remarks

### Mailbox Search and Deletion

#### Shared Mailbox Search Process

The form includes a search field that retrieves matching shared mailboxes using Exchange On-Premise cmdlets:

1. Search Mailboxes (`Get-Mailbox` cmdlet)
   * Mailbox type: Filters by `RecipientTypeDetails = SharedMailbox`
   * Search criteria: Matches against `Name`, `Alias`, `PrimarySmtpAddress`, and `DisplayName`
   * Wildcard support: Uses wildcard matching to find partial matches
   * Returns a list of shared mailboxes for selection

#### Shared Mailbox Deletion Process

When the form is submitted, the following process occurs in Exchange On-Premise:

1. Delete Mailbox (`Remove-Mailbox` cmdlet)
   * The script removes the selected shared mailbox using `Remove-Mailbox` with the `Confirm:$false` parameter
   * The mailbox and all associated data are permanently deleted from Exchange On-Premise
   * No data recovery is possible after deletion

## Development resources

### PowerShell Cmdlets

The following PowerShell cmdlets are used by the connector:

| Cmdlet | Description |
| ------ | ----------- |
| New-PSSession | Create a remote PowerShell session to Exchange On-Premise |
| Import-PSSession | Import cmdlets from the remote Exchange session |
| Get-Mailbox | Search and retrieve mailboxes to find shared mailboxes |
| Remove-Mailbox | Delete a shared mailbox |
| Remove-PSSession | Close the Exchange PowerShell session |

### Documentation

For more information on the PowerShell cmdlets used in this connector, please refer to:

Exchange On-Premise PowerShell:

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