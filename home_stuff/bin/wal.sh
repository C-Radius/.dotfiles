#!/bin/bash
let syntax = "theme_changer mode image
where mode can be -l for light and -d for dark.
Image must be a valid path to an image file."

if [[ $# == 0  ]] || [[ $# > 2 ]]; then
    echo $syntax
    exit 1
fi

let intensity = $1
let image = $2

if [[ -z $intensity  ]] && [[ $intensity != "-l" ]] && [[ $intensity != "-d" ]]; then
    echo "No dark or light mode specified"
    echo $syntax
    exit 1
fi

if [[ -z $image  ]]; then
    echo "No image file specified"
    echo $syntax
    exit 1
fi




