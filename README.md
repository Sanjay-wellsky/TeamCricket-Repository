> # My Repo
This repository contains a collection of PowerShell scripts designed to automate and streamline administrative tasks, enhancing efficiency and organization.

## Table of Contents
- Overview
- Scripts and Descriptions
- How to Use
- Contributing


## Overview
The **TeamCricket Repository** serves as a one-stop solution for various administrative needs, including application installations, file management, and shared directory insights. Whether you're a system administrator or simply someone looking to optimize workflows, this repository provides reliable and efficient solutions.

## Scripts and Descriptions
### 1. Essential Applications Installation.ps1
This script automates the installation of essential applications to set up a functional work environment. The applications include:
- **Chrome**
- **Putty**
- **RSAT Tools**, such as:- 

  - Active Directory Sites & Services
  - Active Directory Users & Computers
  - DNS
  - Group Policy Manager

### 2. UnaccessedFileSweeper.ps1
Efficiently manage and optimize storage with this script. It enables you to:
- Move or delete files from specified locations.
- Perform actions based on the last access date of the files.

### 3. SharedDirectoryInsights.ps1
Gain valuable insights into shared directories using this script. It:
- Exports detailed information about shared directories to a CSV file.

### 4. FSLogix Registry Configuration for Cloud Cache.ps1
Efficiently manage and optimize storage of a virtual desktop environment and the script will perform the below actions:
- Automates creation and update of FSLogix-related registry entries for user profile settings.  
- Ensures registry paths exist and applies specified values consistently.  
- Configures a custom write cache directory efficiently.  
- Improves profile management in virtual desktop environments.  


## How to Use
- Clone the repository:

  `gh repo clone Sanjay-wellsky/My-Repo`

- Navigate to the desired script directory.> 
- Execute the script using PowerShell with appropriate permissions.

Refer to each script's inline comments for additional guidance and customization options.

## Contributing

Contributions are welcome! If you'd like to contribute:
- Fork the repository.
- Create a feature branch: `git checkout -b feature/YourFeature`.
- Commit your changes: `git commit -m 'Add YourFeature'`.
- Push to the branch: `git push origin feature/YourFeature`.
- Create a Pull Request.
