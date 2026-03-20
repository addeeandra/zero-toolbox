#!/bin/bash

docker run 
    --rm --env-file .env 
    -p ${ZEROCLAW_LARAVEL_PORT:-42618}:42617 
    -v ./agents/laravel/config:/zeroclaw-data/.zeroclaw 
    -v ./agents/laravel/workspace:/zeroclaw-data/workspace 
    ghcr.io/addeeandra/zero-toolbox:latest-laravel daemon