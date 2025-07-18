# zipzilla2

**zipzilla2** is a silent, command-line tool for compressing and extracting files and folders on all Linux distributions.

## Usage


![zipzilla2.sh_menu](./images/zipzilla2_menu.png)
![zipzilla2.sh_compression](./images/zipzilla2_compress.png)
![zipzilla2.sh_extraction](./images/zipzilla2_extract.png)


## Features

- **Silent operation:** Minimal output, only success or error messages.
- **Supports multiple files and folders:** Compress or extract several items in a single command.
- **Wide range of formats supported:**
  - Compression: `.tar.gz`, `.gz`, `.bz2`, `.tar.bz2`, `.xz`, `.tar.xz`, `.Z`, `.zip`, `.rar`, `.lzma`, `.7z`
  - Extraction: All above formats
- **Automatic dependency installation:** Detects your Linux package manager and installs required tools if missing.
- **Works on all Linux distros:** Supports `apt`, `pacman`, `dnf`, `yum`, `zypper`, `apk`, and `nix-env`.
