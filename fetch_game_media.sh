#!/bin/bash

source ${PWD}/config/scraper_config.cfg

OUTPUT_DIR="${PWD}/export"
ROMS_MEDIA_ROOT_PATH="${OUTPUT_DIR}/roms_media"
ROMS_GAMELIST_ROOT_PATH="${OUTPUT_DIR}/roms_gamelists"

# Functions

# arg1: platform
function update_platform_data () {
    echo -e "\nGenerating artwork data for platform ${1}... \n"
    videos_option=
    if [[ "$EXPORT_VIDEOS" == "yes" ]]; then videos_option=--videos; fi
    Skyscraper -p ${1} -i ${ROMS_PATH}/${1} -g ${ROMS_GAMELIST_ROOT_PATH} -o ${ROMS_MEDIA_ROOT_PATH} -s screenscraper -u ${CREDENTIALS} --unattend --videos ${FORCE_REFRESH}
}

function run_on_all_platforms {
    for path in "${ROMS_PATH}"/*; do
        if [[ -d "${path}" ]]; then
            platform=$(basename ${path})
            update_platform_data ${platform}
        fi 
    done
}

function print_usage {
    echo -e "\t Usage: \n"
    echo -e "\t ${0} [--force-refresh] [platform1] [platform2] ..."
    echo -e "\n"
    echo -e "\t where:"
    echo -e "\n"
    echo -e "\t --force-refresh: forces a cache update by re-fetching data from scraping service." 
    echo -e "\t                  Specify this if you want to add assets (e.g. videos) to a game already present in the cache."
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
        elif [[ "$arg" == "--force-refresh" ]]; then
            echo -e "*** Forcing cache refresh ***\n"
            FORCE_REFRESH=--refresh
            
            if [[ "$#" -eq 1 ]]; then
            echo -e "No platforms specified, generating media for all of them.\n"
            run_on_all_platforms
            fi
        else
            update_platform_data ${arg}
        fi
    done
fi


echo -e "\tDone. \n"

