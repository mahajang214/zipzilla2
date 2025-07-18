#!/bin/bash
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
PURPLE="\e[95m"
SKY="\e[96m"
RESET="\e[0m"

# global variables
purpose_of_tool=""
args_is=""
compress_type=""
CURRENT_OS_DOWNLOAD_CMD=""

# if no argu then show usage
if [[ "$#" -eq 0 ]]; then
    echo -e "${GREEN}Compression Usage: $0 compress [OPTIONS] [file | folder] <file1> <file2> ...${RESET}"
    echo -e "${GREEN}Extarction Usage: $0 extract [file | folder] <file1> <file2> ...${RESET}"
    
    echo -e "${RED}Please mind the position. ${RESET}"
    
    echo -e "${GREEN}OPTIONS:${RESET}"
    echo "  -gz       Compress using gzip (.gz)"
    echo "  -bz2      Compress using bzip2 (.bz2)"
    echo "  -xz       Compress using xz (.xz)"
    echo "  -zip      Compress into .zip archive"
    echo "  -compress Compress using .z (.Z)"
    echo "  -tar.gz   Create tarball and compress with gzip"
    echo "  -tar.bz2  Create tarball and compress with bzip2"
    echo "  -tar.xz   Create tarball and compress with xz"
    echo "  -rar      Compress using RAR (.rar)"
    echo "  -lzma     Compress using LZMA (.lzma)"
    echo "  -7z       Compress using 7-Zip (.7z)"
    echo
    
    
    echo "$0 is used for (compression or extraction) of (files and folders)."
    exit 1
fi

# Check compress or extract
if [[ "$1" =~ ^c || "$1" =~ ^C ]]; then
    purpose_of_tool="compress"
    shift  # Shift "compress"
    
    if [[ "$1" =~ ^- ]]; then
        compress_type="${1#-}"  # Remove leading dash
        shift  # Shift the compression type
    else
        echo "compression ARGS : $@"
        echo -e "\e[91mPlease enter a compression type. \e[0m"
        echo -e "\e[92mCompression Usage: $0 compress [OPTIONS] [file | folder] <file1> <file2> ...\e[0m"
        exit 1
    fi
    
    elif [[ "$1" =~ ^e || "$1" =~ ^E ]]; then
    purpose_of_tool="extract"
    shift
    
else
    echo "error ARGS : $@"
    echo -e "\n\e[91mPlease define 'compress' or 'extract' as the first argument.\e[0m"
    echo -e "\e[92mCompression Usage: $0 compress [OPTIONS] [file | folder] <file1> <file2> ...\e[0m"
    echo -e "\e[92mExtraction Usage: $0 extract [file | folder] <file1> <file2> ...\e[0m"
    exit 1
fi


detect_os(){
    OS=$(uname -s)
    case $OS in
        Linux*)
            if command -v apt-get &>/dev/null; then
                CURRENT_OS_DOWNLOAD_CMD="apt-get"
                
                elif command -v pacman &>/dev/null; then
                
                CURRENT_OS_DOWNLOAD_CMD="pacman"
                
                elif command -v dnf &>/dev/null; then
                # install_packages "sudo dnf install -y"
                CURRENT_OS_DOWNLOAD_CMD="dnf"
                
                elif command -v yum &>/dev/null; then
                # install_packages "sudo yum install -y"
                CURRENT_OS_DOWNLOAD_CMD="yum"
                
                elif command -v zypper &>/dev/null; then
                # install_packages "sudo zypper install -y"
                CURRENT_OS_DOWNLOAD_CMD="zypper"
                
                elif command -v apk &>/dev/null; then
                # install_packages "sudo apk add"
                CURRENT_OS_DOWNLOAD_CMD="apk"
                
                elif command -v nix-env &>/dev/null; then
                # install_packages "nix-env -iA nixpkgs"
                CURRENT_OS_DOWNLOAD_CMD="nix-env"
                
            else
                echo -e "\e[91m✘ Unsupported Linux distro or missing package manager.\e[0m"
                exit 1
            fi
            
            
            
        ;;
        *)
            echo -e "${RED}Error : your operating system does not support zipzilla2. $RESET"
            exit 1
        ;;
        
    esac
    # echo "OS:$OS";
    # echo "args : ${args_list[@]}"
}
download_tool(){
    for tool in "$@"; do
        if command -v "$tool" >/dev/null 2>&1; then
            continue
        else
            case $CURRENT_OS_DOWNLOAD_CMD in
                apt-get*)
                    sudo apt-get install "$tool" -y
                ;;
                pacman*)
                    sudo pacman -Sy "$tool"
                ;;
                dnf*)
                    sudo dnf install "$tool" -y
                ;;
                yum*)
                    sudo yum install "$tool" -y
                ;;
                zypper*)
                    sudo zypper install "$tool" -y
                ;;
                apk*)
                    sudo apk add "$tool"
                ;;
                nix-env*)
                    sudo nix-env -iA nixpkgs "$tool"
                ;;
                *)
                exit 1;;
                
            esac
        fi
        
    done
    
}
detect_os

# Now $1 is 'file' or 'folder'
if [[ "$1" =~ ^[fF]ile[s]*$ ]]; then
    args_is="files"
    shift
    elif [[ "$1" =~ ^[fF]older[s]*$ ]]; then
    args_is="folders"
    shift
else
    echo -e "\nPlease define 'file' or 'folder' as the second argument. Example:"
    echo -e "${GREEN}Usage: $0 [compress | extract] [file | folder] <file1> <file2> ...${RESET}"
    exit 1
fi

bye(){
    if [[ "$?" -eq 0 ]]; then
        echo -e "${GREEN}Operation Successful. Congratulations $RESET"
    else
        echo -e "${RED}Operation Failed. $RESET"
    fi
}


for arg in "$@"; do
    # compress files
    if [[ "$purpose_of_tool" == "compress" && "$args_is" == "files" ]]; then
        if ! [[ -f "$arg" ]]; then
            echo "File $arg does not exist."
            exit 1
        fi
        
        case "$compress_type" in
            tar.gz)
                download_tool gzip
                tar -czf "$arg.tar.gz" "$arg" 2>/dev/null
            ;;
            tar.bz2)
                download_tool bzip2
                tar -cjf "$arg.tar.bz2" "$arg" 2>/dev/null
            ;;
            tar.xz)
                download_tool xz
                tar -cJf "$arg.tar.xz" "$arg" 2>/dev/null
            ;;
            gz)
                download_tool gzip
                gzip "$arg" 2>/dev/null
            ;;
            bz2)
                download_tool bzip2
                bzip2 "$arg" 2>/dev/null
            ;;
            compress|Compress)
                download_tool compress
                compress "$arg" 2>/dev/null
            ;;
            xz)
                download_tool xz
                xz -k "$arg" 2>/dev/null
            ;;
            zip)
                download_tool zip
                zip "$arg.zip" "$arg" 2>/dev/null
            ;;
            
            rar)
                download_tool rar
                rar a "$arg.rar" "$arg" 2>/dev/null
            ;;
            lzma)
                download_tool lzma
                tar -cf - "$arg" | lzma > "$arg.tar.lzma" 2>/dev/null
            ;;
            7z)
                download_tool 7z
                7z a "$arg.7z" "$arg" 2>/dev/null
            ;;
            *)
                echo -e "${RED}Unsupported compression type: $compress_type${RESET}"
                exit 1
            ;;
        esac
        
        # compress folders
        elif [[ "$purpose_of_tool" == "compress" && "$args_is" == "folders" ]]; then
        if ! [[ -d "$arg" ]]; then
            echo "Folder $arg does not exist."
            exit 1
        fi
        
        case "$compress_type" in
            tar.gz)
                download_tool gzip
                tar -czf "$arg.tar.gz" "$arg" 2>/dev/null
            ;;
            tar.bz2)
                download_tool bzip2
                tar -cjf "$arg.tar.bz2" "$arg" 2>/dev/null
            ;;
            tar.xz)
                download_tool xz
                tar -cJf "$arg.tar.xz" "$arg" 2>/dev/null
            ;;
            zip)
                download_tool zip
                zip -r "$arg.zip" "$arg" 2>/dev/null
            ;;
            7z)
                download_tool 7z
                7z a "$arg.7z" "$arg" 2>/dev/null
            ;;
            rar)
                download_tool rar
                rar a "$arg.rar" "$arg" 2>/dev/null
            ;;
            lzma)
                download_tool lzma
                tar -cf - "$arg" | lzma > "$arg.tar.lzma" 2>/dev/null
            ;;
            *)
                echo -e "${RED}Unsupported compression type for folders: $compress_type${RESET}"
                exit 1
            ;;
        esac
        
        # extract files
        elif [[ "$purpose_of_tool" == "extract" && "$args_is" == "files" ]]; then
            if ! [[ -f "$arg" ]]; then
            echo "$arg does not exist."
            exit 1
            fi
    
            if [[ "$arg" == *.tar.gz ]]; then
            download_tool tar
            tar -xzf "$arg" 2>/dev/null
            elif [[ "$arg" == *.tar.bz2 ]]; then
            download_tool tar
            tar -xjf "$arg" 2>/dev/null
            elif [[ "$arg" == *.tar.xz ]]; then
            download_tool tar
            tar -xJf "$arg" 2>/dev/null
            elif [[ "$arg" == *.gz ]]; then
            download_tool gzip
            gunzip "$arg" 2>/dev/null
            elif [[ "$arg" == *.bz2 ]]; then
            download_tool bzip2
            bunzip2 "$arg" 2>/dev/null
            elif [[ "$arg" == *.xz ]]; then
            download_tool xz
            unxz "$arg" 2>/dev/null
            elif [[ "$arg" == *.Z ]]; then
            download_tool compress
            ncompress "$arg" 2>/dev/null
            elif [[ "$arg" == *.zip ]]; then
            download_tool unzip
            unzip "$arg" 2>/dev/null
            elif [[ "$arg" == *.7z ]]; then
            download_tool 7z
            7z x "$arg" 2>/dev/null
            elif [[ "$arg" == *.rar ]]; then
            download_tool unrar
            unrar x "$arg" 2>/dev/null
            elif [[ "$arg" == *.lzma ]]; then
            download_tool lzma
            unlzma "$arg" 2>/dev/null
            elif [[ "$arg" == *.tar ]]; then
            download_tool tar
            tar -xf "$arg" 2>/dev/null
            
            
            else
            echo -e "${RED}Unsupported format: $arg${RESET}"
            exit 1
            fi
        
        # extract folders (if required: e.g., detect archive contains folder)
        elif [[ "$purpose_of_tool" == "extract" && "$args_is" == "folders" ]]; then
            if ! [[ -f "$arg" ]]; then
                echo "$arg does not exist."
                exit 1
            fi
        
            # Relying on the file type to determine it's a folder archive
            case "$arg" in
            *.tar.gz)
                download_tool tar
                tar -xzf "$arg" 2>/dev/null
            ;;
            *.tar.bz2)
                download_tool tar
                tar -xjf "$arg" 2>/dev/null
            ;;
            *.tar.xz)
                download_tool tar
                tar -xJf "$arg" 2>/dev/null
            ;;
            *.zip)
                download_tool unzip
                unzip "$arg" 2>/dev/null
            ;;
            *.7z)
                download_tool 7z
                7z x "$arg" 2>/dev/null
            ;;
            *.rar)
                download_tool unrar
                unrar x "$arg" 2>/dev/null
            ;;
            *.tar.lzma)
                download_tool lzma
                lzma -d -c "$arg" | tar -x 2>/dev/null
            ;;
            *.tar)
                download_tool tar
                tar -xf "$arg" 2>/dev/null
            ;;
            *)
                echo -e "${RED}Unsupported archive type for folders: $arg${RESET}"
                exit 1
            ;;
            esac
    fi
done

bye


