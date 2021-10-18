#!/usr/bin/env bash

function mcr_repo_ls() {
    curl --silent -L \
        "https://mcr.microsoft.com/v2/_catalog"
}
function mcr_repo_ls_txt(){
    mcr_repo_ls \
        | jq -r ".repositories[]" \
        | sort
}


function mcr_tag_ls() {
    image=$1
    curl --silent -L \
        "https://mcr.microsoft.com/v2/${image}/tags/list"
}
function mcr_tag_ls_txt() {
    mcr_tag_ls "$1" \
        | jq -r ".tags[]" \
        | sort
}


mcr_repo_ls_txt > repos.txt

# base images (windows)
mcr_tag_ls_txt windows > windows.tags.txt 
mcr_tag_ls_txt windows/nanoserver > windows.nanoserver.tags.txt 
mcr_tag_ls_txt windows/server > windows.server.tags.txt 
mcr_tag_ls_txt windows/servercore > windows.servercore.tags.txt 

# fwk images
mcr_tag_ls_txt dotnet/sdk > dotnet.sdk.tags.txt 

# app images
mcr_tag_ls_txt mssql/server > mssql.server.tags.txt 
# https://hub.docker.com/_/microsoft-windows-servercore-iis
# teaser about this iis image: https://techcommunity.microsoft.com/t5/containers/contain-your-excitement-updates-on-windows-server-2022-and/ba-p/2820015
mcr_tag_ls_txt windows/servercore/iis > iis.tags.txt 
