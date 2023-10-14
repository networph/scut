<br/>
<p align="center">
  <h3 align="center">SCUT</h3>

  <p align="center">
    SCUT is a simple bash tool designed to manage and utilize custom shortcuts to streamline your terminal experience.
    <br/>
    <br/>
    <a href="https://github.com/networph/scut/issues">Report a Bug</a>
    .
    <a href="https://github.com/networph/scut/issues">Request a Feature</a>
  </p>
</p>

![Contributors](https://img.shields.io/github/contributors/networph/scut?color=dark-green) ![Issues](https://img.shields.io/github/issues/networph/scut) ![License](https://img.shields.io/github/license/networph/scut) 

## Table Of Contents

* [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Authors](#authors)
* [Acknowledgements](#acknowledgements)

## Built With

    Bash: scut is fundamentally crafted using Bash scripting, providing a robust mechanism for managing shell command shortcuts efficiently and effectively. The scripts cater to creating, listing, favoriting, and managing shortcuts directly from your terminal, embedding themselves into your .bashrc for persistence and ease of use.

    GitHub: The entire scut project is hosted on GitHub, facilitating not only version control and issue tracking but also serving as the central hub for user acquisition, collaboration, and contribution. This platform provides users with detailed information, documentation, and the ability to download or clone the project for personal or developmental use.

### Prerequisites

    Bash Shell: Ensure that your system is using Bash as its shell. Most Unix-like operating systems like Linux and macOS use Bash by default.
    Git: To clone the repository directly from GitHub.
    curl or wget (optional): If you want to download the script directly without Git

    use brew for installing on MacOS. Im on arch, so below is what arch users will do.
    
Installing Git

```sudo pacman -Syu git```

Installing Curl

```sudo pacman -Syu curl```

Installing Wget

```sudo pacman -Syu wget```

### Installation

WIth git:

Navigate to the directory where you want to clone the scut repository, and run:
```git clone https://github.com/networph/scut.git```

Step 2: Navigate to the Project Directory

Change into the newly cloned scut directory:
```cd src/scut```

Then run:
```chmod +x src/scut.sh```

Move the script:
```mv scut.sh /usr/local/bin/scut```

## Usage

Use scut man in terminal, Once you have installed.

## Roadmap

[v 1.1.0] - Backup & Restore: Anticipated Release - March 2023

    Backup and Restore: Safeguard and reclaim your shortcuts with ease.

[v 1.1.9] - Grouping of Shortcuts: Anticipated Release - April 2023

    Group Management: Categorize your shortcuts for a structured, accessible setup.

[v 1.2.8] - Shortcut Sharing: Anticipated Release - May 2023

    Sharing Capabilities: Simplify sharing of shortcut setups between various systems and colleagues.

[v 1.3.7] - Enhanced Interaction & Management: Anticipated Release - June 2023

    Interactive UI: Facilitate effortless management and overview of your shortcuts through interactive sessions.

[v 1.4.6] - Integration with Additional Shell Types: Anticipated Release - July 2023

    Cross-Shell Compatibility: Expand scut to be compatible with other shells like zsh and fish.


## Authors

* **networth** - *Main dev | Read profile* - [networth](https://github.com/networph/) - *everything*

## Acknowledgements

* [Friends]()
* [Google]()
* [Brain]()
