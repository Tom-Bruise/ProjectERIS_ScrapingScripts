#!/bin/bash

source ${PWD}/config/scraper_config.cfg

ARTWORK_FILE=${PWD}/config/artwork.xml
OUTPUT_DIR="${PWD}/export"
ROMS_MEDIA_ROOT_PATH="${OUTPUT_DIR}/roms"
ROMS_GAMELIST_ROOT_PATH="${OUTPUT_DIR}/roms"

GAMELIST_FILE="gamelist.xml"
RETROARCH_ROMS_PATH="/media/roms"

# Functions

# arg1: platform
function generate_media_for_platform () {
    platform=$(echo ${1} | awk '{print tolower($0)}')
    videos_option=
    if [[ "$EXPORT_VIDEOS" == "yes" ]]; then videos_option=--videos; fi
    Skyscraper -p ${platform} -i ${ROMS_PATH}/${1} -g ${ROMS_MEDIA_ROOT_PATH}/${1}  -o ${ROMS_MEDIA_ROOT_PATH}/${1} -a ${ARTWORK_FILE} ${videos_option}
    patch_gamelist_paths_for_platform ${1}
}

# arg1: platform
function patch_gamelist_paths_for_platform () {
    gamelist_file_full_path="${ROMS_MEDIA_ROOT_PATH}/${1}/${GAMELIST_FILE}"

    if [[ -f "${gamelist_file_full_path}" ]]; then
        # Fix rom and media paths in generated gamelist to reflect Project Eris install
        sed -i -e "s|${ROMS_PATH}|${RETROARCH_ROMS_PATH}|g;s|${ROMS_MEDIA_ROOT_PATH}|${RETROARCH_ROMS_PATH}|g" ${gamelist_file_full_path}
    fi 
}

function run_on_all_platforms {
    for dir in "${ROMS_PATH}"/*; do
        # If it's a directory
        if [[ -d "${dir}" ]]; then
            # And the directory is not empty
            if [ ! -z "$(ls -A ${dir})" ]; then
                platform=$(basename ${dir})
                generate_media_for_platform ${platform}
            fi
        fi 
    done
}

function print_usage {
    echo -e "\t Usage: \n"
    echo -e "\t ${0}  [platform1] [platform2] ..."
    echo -e "\t where:"
    echo -e "\n"
    echo -e "\t        platform: a list of platforms supported by SkyScraper. If left blank, all platforms in the rom folder" 
    echo -e "\t                  are processed."
}

# Main

if [[ ! -d "${ROMS_PATH}" ]]; then 
    echo -e "Path to roms does not exist, aborting."
    exit -1
fi

if [[ "$#" -eq 0 ]]; then
    echo -e "No platforms specified, generating media for all of them.\n"
    run_on_all_platforms
    exit 0;
fi
    
if [[ "$#" -gt 0 ]]; then
    for arg
    do
        if [[ "$arg" ==  "-h" ]]; then
            print_usage
            exit 0
        else
            generate_media_for_platform ${arg}
        fi
    done
fi

