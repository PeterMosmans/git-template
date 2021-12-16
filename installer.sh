#!/usr/bin/env bash

# installer - A generic installer script
#
# Copyright (C) 2015-2021 Peter Mosmans
#                         <support AT go-forward.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# SPDX-License-Identifier: GPL-3.0-or-later

# shellcheck disable=SC2034
VERSION=1.5

# For configuration, use the INIFILE
INIFILE=.installerrc

# The configuration file .installerrc should contain all installer-specific settings:
# COPYFILES, LINKFILES, OSFILES, COMMITFILES and EXECUTABLES.

# COPYFILES: Files to copy.
# An array of relative location from where the script is run, and files.
#
# Example:
# COPYFILES=(
#     [.]=" .versionrc"
#     [.git/hooks]="pre-commit"
# )
#
# This will copy the file .versionrc to the target folder,
# and pre-commit to the folder .git/hooks

# LINKFILES: OS-independent files to link.
# An array of relative location from where the script is run, and files.
#
# Example:
# LINKFILES=(
#     [.]=".aliases"
#     [.emacs.d]="init.el"
# )
#
# This will link the source file .aliases to .aliases in the target folder,
# and the source file .emacs.d/init.el to .emacs.d/init.el in the target folder

# OSFILES: Files to link, depending on OS
# Source files will be read from within the os_name subdirectory
#
# Example:
# OSFILES=(
#     [.]=".zshenv"
#     [.ssh]="config"
# )
#
# If executed on GNU-Linux, this will link the source file GNU-Linux/.zshenv to .zshenv in the target folder,
# and the source file GNU-Linux/.ssh/config to .ssh/config in the target folder.

# EXECUTABLES: Files that should be on the search path and accessible.
#
# Example:
# EXECUTABLES="lint-jenkins"
#
# This will search for lint-jenkins, and emits a warning if the file cannot be found/executed.
# A warning will be shown if any of the files cannot be found (on the search paths)

# COMMITFILES: Files that will be committed to the (new) repo in the target folder.
#
# Examples:
# COMMITFILES="Makefile"
#
# CLEANUPFILES: Files that will be cleaned up from the target folder.

# Define associative arrays
declare -A COPYFILES
declare -A LINKFILES
declare -A OSFILES

os=$(uname -o|sed "s/\//-/")
source="$(dirname "$(readlink -f "$0")")"
target=$1

usage() {
    # Check whether the script is being executed from within the source directory
    # And if not, display basic usage
    if [ -z "$target" ]; then
        target=$(readlink -f .)
        if [ "${target}" == "${source}" ]; then
            cat << EOF
installer.sh v${VERSION} - a generic installer script - PGCM - support@go-forward.net

Usage: installer.sh [TARGET]
       or run from within target directory
EOF
            exit
        fi
    fi
}

read_settings() {
    # Read the settings
    INIFILE="${source}/${INIFILE}"
    if [[ ! -f "${INIFILE}" ]]; then
        echo "[-] Could not find ${INIFILE}: required as it contains installer setings"
        exit 1
    fi
    echo "[*] Reading settings from ${INIFILE}"
    # shellcheck disable=SC1090
    source "${INIFILE}"
}

check_executables() {
    # Check if executables are available
    # shellcheck disable=SC2154
    if [[ -n ${EXECUTABLES} ]]; then
        echo "[*] Checking whether executables can be found..."
        # shellcheck disable=SC2154
        for executable in ${EXECUTABLES}; do
            if ! which "${executable}" &>/dev/null; then
                echo "[!] Could not find ${executable} in paths: Not everything might work correctly"
                WARNING=1
            fi
        done
    fi
}

copy_files() {
    # Copy files from the source dir to the target
    if (( ${#COPYFILES[@]} == 0 )); then
        return
    fi
    echo "[*] Copying files from $source"
    for targetdirectory in "${!COPYFILES[@]}"; do
        mkdir -p "${target}/${targetdirectory}/" &>/dev/null
        for file in ${COPYFILES[$targetdirectory]}; do
            cp --recursive --update "${source}/${targetdirectory}/${file}" "${target}/${targetdirectory}/${file}"
        done
    done
}

link_files() {
    # Link files
    if (( ${#LINKFILES[@]} == 0 )); then
        return
    fi
    echo "[*] Linking files from $source"
    for targetdirectory in "${!LINKFILES[@]}"; do
        mkdir -p "${target}/${targetdirectory}/" &>/dev/null
        for file in ${LINKFILES[$targetdirectory]}; do
            ln -fv "${source}/${targetdirectory}/${file}" "${target}/${targetdirectory}/${file}"
        done
    done
    }

link_os_files() {
    # Link operating-system specific files
    if (( ${#OSFILES[@]} == 0 )); then
        return
    fi
    echo "[*] Linking files from $source"
    for targetdirectory in "${!OSFILES[@]}"; do
        for file in ${OSFILES[$targetdirectory]}; do
            if [[ -f "${source}/${os}/${file}" ]]; then
                ln -fv "${source}/${os}/${targetdirectory}/${file}" "${target}/${targetdirectory}/${file}"
            fi
        done
    done
}

cleanup_files() {
    # Clean up files in the target directory
    if [ -z "${CLEANUPFILES}" ]; then
        return
    fi
    echo "[*] Cleaning up files in $target"
    for cleanup in ${CLEANUPFILES}; do
        echo rm -rf "$target/$cleanup"
    done
}

generate_source_version_tag() {
    # Generate a version tag based on the git source dir
    echo "Initial source of this repository is $(git -C "$source" log --oneline -1)" > "$target/SOURCEVERSION"
    echo "Branch $(git -C "$source" rev-parse --abbrev-ref HEAD) and tag $(git -C "$source" describe --tags --abbrev=0)" >> "$target/SOURCEVERSION"
}

commit_files() {
    # Commit files
    # Only continue if git status is clean
    if [ -z "${COMMITFILES}" ]; then
        return
    fi
    if [[ -z "$(git status --untracked-files=no --porcelain)" ]]; then
        echo "[*] Committing files"
        # shellcheck disable=SC2154
        for commitfile in ${COMMITFILES}; do
            git add "$commitfile"
        done
        git commit -m "feat(ci): add initial files"
    else
        echo "[-] Not committing files, as repository status is unclean"
    fi
}

finish() {
    if [[ -n "$WARNING" ]]; then
        echo "[!] Done, but with warnings"
    else
        echo "[+] Done"
    fi
}

main () {
    # Main script loop
    usage
    read_settings
    check_executables
    copy_files
    link_files
    link_os_files
    cleanup_files

    if [ "$GIT_INIT" = true ]; then
        echo "[*] Initializing git repository"
        git init "$target"
        $GIT_INSTALLER
    fi

    if [ "$GIT_SOURCE_TAG" = true ]; then
        echo "[*] Generating source tag"
        generate_source_version_tag
    fi

    commit_files
    finish
}

main
