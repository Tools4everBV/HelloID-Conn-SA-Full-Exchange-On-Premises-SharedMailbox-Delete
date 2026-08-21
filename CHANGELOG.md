# Changelog

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/), and this project adheres to [Semantic Versioning](https://semver.org/).

## [2.0.0] - 2026-08-21

### Added

- Added TLS 1.2 enforcement in task script for secure connections
- Added structured action messages throughout task script for better debugging and error tracking
- Added selective command import to only load required Exchange cmdlets (Remove-Mailbox)

### Changed

- Refactored task script from bulk delete (looping through multiple mailboxes) to single mailbox delete operation
- Improved error handling with structured try-catch-finally pattern and detailed error messages
- Improved datasource script with comprehensive session option parameters and better error context
- Improved Exchange session management with proper cleanup in finally block
- Updated credential creation to use explicit splatting for better code readability

### Fixed

- Fixed potential session leaks by implementing proper session cleanup in finally block
- Fixed datasource to return more comprehensive mailbox information for better selection context
- Fixed form to prevent accidental bulk deletion of shared mailboxes

## [1.0.0] - 2023-08-18

Initial release of HelloID-Conn-SA-Full-Exchange-On-Premises-SharedMailbox-Delete.

### Added

- Initial release for deleting Exchange On-Premises Shared Mailboxes
