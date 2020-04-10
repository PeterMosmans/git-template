#!/usr/bin/env bash

# installer - Basic installer (linker) for various files
#
# Copyright (C) 2015-2020 Peter Mosmans
#                         <support AT go-forward.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Define associative arrays
declare -A copyfiles
declare -A linkfiles
declare -A osfiles



# The file .installerrc should contain all installer-specific files:
# copyfiles, linkfiles, osfiles and executables.

# copyfiles: Files to copy.
# An array of relative location from where the script is run, and files.
#
# Example:
# copyfiles=(
#     [.]=" .versionrc"
#     [.git/hooks]="pre-commit"
# )
#
# This will copy the file .versionrc to the target folder,
# and pre-commit to the folder .git/hooks

# linkfiles: OS-independent files to link.
# An array of relative location from where the script is run, and files.
#
# Example:
# linkfiles=(
#     [.]=".aliases"
#     [.emacs.d]="init.el"
# )
#
# This will link the source file .aliases to .aliases in the target folder,
# and the source file .emacs.d/init.el to .emacs.d/init.el in the target folder

# osfiles: Files to link, depending on OS
# Source files will be read from within the os_name subdirectory
#
# Example:
# osfiles=(
#     [.]=".zshenv"
#     [.ssh]="config"
# )
#
# If executed on GNU-Linux, this will link the source file GNU-Linux/.zshenv to .zshenv in the target folder,
# and the source file GNU-Linux/.ssh/config to .ssh/config in the target folder.

# executables: Files that should be on the search path and accessible.
#
# Example:
# executables="lint-jenkins"
#
# This will search for lint-jenkins, and emits a warning if the file cannot be found/executed.
# A warning will be shown if any of the files cannot be found (on the search paths)

VERSION=1.0

os=$(uname -o|sed "s/\//-/")
source=$(dirname $(readlink -f $0))
target=$1

# Read the settings
source ${source}/.installerrc

usage() {
    # Check whether the script is being executed from within the source directory
    if [ -z "$target" ]; then
        target=$(readlink -f .)
        if [ "${target}" == "${source}" ]; then
            echo "Usage: installer.sh [TARGET]"
            echo "       or run from within target directory"
            exit
        fi
    fi
}

copy_files() {
    # Copy files
    for targetdirectory in "${!copyfiles[@]}"; do
        mkdir -p ${target}/${targetdirectory}/ &>/dev/null
        for file in ${copyfiles[$targetdirectory]}; do
            cp -uv ${source}/${targetdirectory}/${file} ${target}/${targetdirectory}/${file}
        done
    done
}

link_files() {
    # Link files
    for targetdirectory in "${!linkfiles[@]}"; do
        mkdir -p ${target}/${targetdirectory}/ &>/dev/null
        for file in ${linkfiles[$targetdirectory]}; do
            ln -fv ${source}/${targetdirectory}/${file} ${target}/${targetdirectory}/${file}
        done
    done
    }

link_os_files() {
    # Link operating-system specific files
    for targetdirectory in "${!osfiles[@]}"; do
        for file in ${osfiles[$targetdirectory]}; do
            if [[ -f ${source}/${os}/${file} ]]; then
                ln -fv ${source}/${os}/${targetdirectory}/${file} ${target}/${targetdirectory}/${file}
            fi
        done
    done
    }

check_executables() {
    # Check if executables are available
    echo "[*] Checking whether executables can be found..."
    for executable in ${executables}; do
        if [[ -z "$(which ${executable} 2>/dev/null)" ]] ; then
            echo "[!] Could not find ${executable} in paths: Not everything might work correctly"
            WARNING=1
        fi
    done
}

finish() {
    if [[ -n "$WARNING" ]]; then
        echo "[!] Done, but with warnings"
        exit 1
    else
        echo "[+] Done"
    fi
}

echo "[*] Installing..."
usage
copy_files
link_files
link_os_files
check_executables
finish
