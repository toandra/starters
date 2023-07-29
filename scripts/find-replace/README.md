# Scripts for Windows and Bash

## Introduction

This is an open-source script designed to automate repository cloning, searching, and replacing specific strings in Maven projects. The script is written in both PowerShell (for Windows OS) and Bash (for Unix-like systems). It allows you to provide a single repository URL or a CSV file with a list of repository URLs as input.

## Prerequisites

Before running the script, make sure you have the following prerequisites set up:

- **Git**: Ensure that Git is installed and properly configured on your system.

## powershell

To run the script with a single repository URL as input:

```powershell
.\PowerShellScript.ps1 https://github.com/user/repo.git
``````

To run the script with a .csv file as input (assuming the file contains a "repos" column):
```powershell
.\PowerShellScript.ps1 -csv C:\path\to\repos.csv
``````

## bash
To run the script with a single repository URL as input:

```shell
./bash_script.sh https://github.com/user/repo.git
```````

To run the script with a .csv file as input (assuming the file contains a column named "repos"):

```shell 
./bash_script.sh -csv /path/to/repos.csv
``````

### Please ensure you have the necessary permissions to execute the script (bash_script.sh). You can make the script executable using chmod +x bash_script.sh.

### Disclaimer
- This script is provided as open source and comes without any warranty. Use it at your own risk, and be cautious while running scripts from unknown sources. Always review and understand the script content before execution.

### Contributing
- Contributions to this open source script are welcome! If you have any improvements, bug fixes, or additional features to add, feel free to create pull requests.

### License
 - This script is released under the MIT License. Feel free to modify, distribute, and use it according to the terms of the license.
