# HelloID-Conn-SA-Full-Exchange-On-Premises-SharedMailbox-Delete

| :information_source: Information                                                                                                                                                                                                                                                                                                                                                          |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description

HelloID-Conn-SA-Full-Exchange-On-Premises-SharedMailbox-Delete is a template designed for use with HelloID Service Automation (SA) Delegated Forms. It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can safely delete Exchange On-Premises shared mailboxes through a structured workflow. The following steps are performed:

1. Search for shared mailboxes using wildcard search on name, alias, or SMTP address
2. Select the shared mailbox to delete from the filtered results
3. Review the mailbox details including all email addresses and recipient type
4. Confirm deletion of the selected shared mailbox
5. The shared mailbox is permanently deleted from Exchange On-Premises

## Getting started

### Requirements

- **Exchange On-Premises Environment**:<br>
  The connector requires access to an Exchange On-Premises server with PowerShell remoting enabled. Ensure the Exchange Management Shell is accessible via remote PowerShell session.

- **Service Account with Appropriate Permissions**:<br>
  A service account with permissions to delete shared mailboxes in Exchange On-Premises is required. The account must have the necessary Exchange RBAC roles assigned (typically Exchange Recipient Administrator or Organization Management).

- **PowerShell Remoting**:<br>
  PowerShell remoting must be enabled on the Exchange server, and the HelloID agent must be able to establish remote PowerShell sessions to the Exchange Management Shell endpoint.

- **Network Connectivity**:<br>
  The HelloID agent server must have network access to the Exchange server's PowerShell endpoint (typically HTTPS on port 443 or HTTP on port 80 depending on your configuration).

- **TLS 1.2 Support**:<br>
  The connector enforces TLS 1.2 for secure communication. Ensure that both the HelloID agent server and Exchange server support TLS 1.2.

### Connection settings

The following user-defined variables are used by the connector.

| Setting               | Description                                                                          | Mandatory |
| --------------------- | ------------------------------------------------------------------------------------ | --------- |
| ExchangeConnectionUri | The URI to the Exchange PowerShell endpoint (e.g., http://exchangeserver/powershell) | Yes       |
| ExchangeAdminUsername | The username of the service account with Exchange permissions                        | Yes       |
| ExchangeAdminPassword | The password of the service account                                                  | Yes       |

## Remarks

### Single Selection Only

The form is configured to allow only single mailbox selection at a time. This design choice helps prevent accidental bulk deletions of shared mailboxes and ensures each deletion is intentional and reviewed.

### Permanent Deletion

When a shared mailbox is deleted using this connector, it is permanently removed from Exchange On-Premises using the `Remove-Mailbox` cmdlet. The deletion cannot be easily undone. Ensure proper approval workflows are in place before granting access to this delegated form.

### Session Management

The connector implements robust session management with automatic cleanup in a finally block. This ensures that Exchange PowerShell sessions are properly closed even if an error occurs during the deletion process, preventing session leaks.

### Wildcard Search Behavior

The datasource supports wildcard searches across multiple mailbox attributes including Name, SamAccountName, Alias, and PrimarySmtpAddress. An asterisk (\*) can be used as the search value to retrieve all shared mailboxes (not recommended for large environments).

### Limited Command Import

The task script only imports the `Remove-Mailbox` cmdlet from the Exchange session rather than all available cmdlets. This reduces memory overhead and improves performance, especially in environments with many concurrent sessions.

### Audit Logging

All operations including connection establishment, mailbox deletion, and disconnection are logged with detailed audit information. These logs are sent to HelloID's audit system and can be used for compliance reporting and troubleshooting.

### Certificate Validation

The connector is configured with certificate validation checks (`SkipCACheck`, `SkipCNCheck`, `SkipRevocationCheck` all set to `false`). Ensure your Exchange server has a valid SSL certificate if using HTTPS endpoints. If you need to bypass certificate validation in test environments, these parameters can be adjusted in the datasource and task scripts.

## Development resources

### PowerShell Datasource

| Datasource Name                                                                                         | Description                                                                                                                             |
| ------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| exchange-on-premises-sharedmailbox-delete \| Exchange-On-Premises-Get-Sharedmailbox-Wildcard-Name-Alias | Retrieves shared mailboxes matching the search criteria using wildcard filtering on Name, SamAccountName, Alias, and PrimarySmtpAddress |

### Delegated Form Task

| Task Name                                     | Description                                                                                   |
| --------------------------------------------- | --------------------------------------------------------------------------------------------- |
| Exchange On-Premises - Sharedmailbox - Delete | Deletes the selected shared mailbox from Exchange On-Premises using the Remove-Mailbox cmdlet |

### Exchange PowerShell Documentation

- [Connect to Exchange servers using remote PowerShell](https://learn.microsoft.com/en-us/powershell/exchange/connect-to-exchange-servers-using-remote-powershell)
- [Remove-Mailbox cmdlet documentation](https://learn.microsoft.com/en-us/powershell/module/exchange/remove-mailbox)

## Getting help

> :bulb: **Tip:**  
> _For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages_.

## HelloID docs

The official HelloID documentation can be found at: https://docs.helloid.com/
