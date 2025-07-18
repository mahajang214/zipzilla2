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
  - **Wide range of formats supported:**

| Format      | Extension(s) | Type             | Description                                   |
| ----------- | ------------ | ---------------- | --------------------------------------------- |
| Gzip        | `.gz`        | Compress/Extract | GNU zip compression (single file)             |
| Bzip2       | `.bz2`       | Compress/Extract | Burrows–Wheeler compression (single file)     |
| XZ          | `.xz`        | Compress/Extract | LZMA2 compression (single file)               |
| Zip         | `.zip`       | Compress/Extract | Standard ZIP archive (multiple files/folders) |
| Compress    | `.Z`         | Compress/Extract | Unix compress utility (older, single file)    |
| Tar + Gzip  | `.tar.gz`    | Compress/Extract | Tarball archive compressed with gzip          |
| Tar + Bzip2 | `.tar.bz2`   | Compress/Extract | Tarball archive compressed with bzip2         |
| Tar + XZ    | `.tar.xz`    | Compress/Extract | Tarball archive compressed with xz            |
| RAR         | `.rar`       | Compress/Extract | RAR archive (multiple files/folders)          |
| LZMA        | `.lzma`      | Compress/Extract | Lempel–Ziv–Markov chain compression           |
| 7-Zip       | `.7z`        | Compress/Extract | 7-Zip archive format                          |

- Extraction: All above formats
- **Automatic dependency installation:** Detects your Linux package manager and installs required tools if missing.
- **Works on all Linux distros:**

| Distribution Family | Supported Package Managers |
| ------------------- | -------------------------- |
| Debian/Ubuntu       | `apt`                      |
| Arch Linux          | `pacman`                   |
| Fedora/RHEL/CentOS  | `dnf`, `yum`               |
| openSUSE            | `zypper`                   |
| Alpine              | `apk`                      |
| NixOS               | `nix-env`                  |
