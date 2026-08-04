# Change Log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [2.0.0] - 2026-08-04

### Added

* Search functionality expanded to include EmailAddresses field
* Wildcard search across multiple mailbox properties (Name, Alias, DisplayName, PrimarySmtpAddress, EmailAddresses)
* Comprehensive README with detailed setup instructions, requirements, and development resources
* Exchange On-Premises setup requirements section in README
* TLS 1.2 enforcement for secure connections
* Comprehensive audit logging with proper tagging for all operations (connect, delete, disconnect)
* Proper error handling with try/catch/finally blocks for session cleanup
* Filter optimization with special handling for "*" wildcard search

### Changed

* **BREAKING:** Data source renamed from `[powershell-datasource]_Exchange-delete-sharedmailbox-generate-table-wildcard` to `[powershell-datasource]_Exchange-on-premise-get-sharedmailboxes`
* **BREAKING:** Task renamed from `[task]_Exchange on-premise - Delete shared mailbox` to `[task]_Exchange-on-premise-delete-sharedmailbox`
* Repository naming corrected from "On-Premise" to "On-Premises" throughout all files
* Search capabilities enhanced:
  * Previously searched only Name field
  * Now searches Name, Alias, DisplayName, PrimarySmtpAddress, and EmailAddresses
  * Improved wildcard matching logic
* Data source refactored with best practices:
  * Filter definition moved to top of script for better readability
  * Optimized filter logic based on search value
  * Returns structured objects with all relevant properties
* Task script refactored with enhanced error handling:
  * Audit logging for all operations
  * Proper session cleanup in finally block
  * Better error messages with context
* README structure modernized:
  * Added information banner about connection requirements
  * Added Getting started section with Requirements
  * Added Exchange On-Premises Setup subsection
  * Added HelloID-specific configuration subsection
  * Added Development resources section with cmdlet documentation
  * Removed outdated Table of Contents
  * Removed All-in-one setup section details
  * Streamlined connection settings table

### Removed

* Old JSON configuration files:
  * `[powershell-datasource]_Exchange-delete-sharedmailbox-generate-table-wildcard.inputs.json`
  * `[powershell-datasource]_Exchange-delete-sharedmailbox-generate-table-wildcard.model.json`
  * `[task]_Exchange on-premise - Delete shared mailbox.config.json`
* Old `dynamicform.json` file
* Unnecessary Write-Information messages (kept only result count and audit logs)
* Table of Contents from README
* Versioning table from README (moved to CHANGELOG.md)
* Forum link from README
* Manual resources detailed section from README

### Fixed

* Inconsistent naming throughout repository ("On-Premise" vs "On-Premises")
* Session cleanup now properly handled in finally block to prevent session leaks
* Filter placement improved for better code readability
* Search functionality now properly includes all email addresses associated with mailbox

## [1.0.0] - 2023-08-18

### Added

* Initial release of HelloID-Conn-SA-Full-Exchange-On-Premises-SharedMailboxDelete
* Shared mailbox deletion functionality for Exchange On-Premises
* Form-based mailbox deletion workflow
* Search functionality to locate shared mailboxes by name
* PowerShell data source for mailbox search (`[powershell-datasource]_Exchange-delete-sharedmailbox-generate-table-wildcard`)
* Delegated form task for mailbox deletion (`[task]_Exchange on-premise - Delete shared mailbox`)
* Basic README with setup instructions
* All-in-one PowerShell setup script for automated deployment
