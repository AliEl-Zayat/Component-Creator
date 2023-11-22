#!/bin/bash

defaultOutputPath="C:\Users\Administrator\Desktop\Development\NASNAV\nasnav-react\src\Themes\Yumazing\Components" # Set your default output path here

# Ask for the output path if the default isn't provided in the script
if [ -z "$defaultOutputPath" ]; then
    read -p "Enter the default output path: " defaultOutputPath
fi

if [ -z "$defaultOutputPath" ]; then
    echo "Please provide a default output path."
    exit 1
fi

# Ask if user wants to use TypeScript
read -p "Using TypeScript? (Yes/No): " useTypescript

if [[ "$useTypescript" =~ ^[Yy](es)?$ ]]; then
    fileExtensions="tsx"
    indexFile="index.ts"
else
    fileExtensions="jsx"
    indexFile="index.js"
fi

while true; do
    read -p "Enter component name (or 'exit' to quit): " userInput

    # Extract the component name and check for -ui flag 
    componentName=$(echo "$userInput" | cut -d' ' -f1)
    isUiFlag=$(echo "$userInput" | grep -o '\-ui')

    # Check if user wants to exit
    if [ "$componentName" == "exit" ]; then
        echo "Exiting..."
        break
    fi

    # Check if componentName is provided
    if [ -z "$componentName" ]; then
        echo "Please provide a component name."
    else
        # Use default output path
        outputPath="$defaultOutputPath"

        # Check for -ui flag in user input
        if [ ! -z "$isUiFlag" ]; then
            outputPath="$outputPath/UI"
            mkdir -p "$outputPath"
        fi

        # Create folder and files
        folderPath="$outputPath/$componentName"
        mkdir -p "$folderPath"
        touch "$folderPath/$componentName.$fileExtensions"
        touch "$folderPath/$componentName.module.scss"
        touch "$folderPath/$indexFile"

        # Write content to componentName file
        echo "import React from 'react';" > "$folderPath/$componentName.$fileExtensions"
        echo "import Styles from './$componentName.module.scss';" >> "$folderPath/$componentName.$fileExtensions"
        echo "" >> "$folderPath/$componentName.$fileExtensions"
        echo "const $componentName = () => {" >> "$folderPath/$componentName.$fileExtensions"
        echo "  return <></>;" >> "$folderPath/$componentName.$fileExtensions"
        echo "};" >> "$folderPath/$componentName.$fileExtensions"
        echo "" >> "$folderPath/$componentName.$fileExtensions"
        echo "export default $componentName;" >> "$folderPath/$componentName.$fileExtensions"

        # Write content to index file
        echo "export { default } from './$componentName';" > "$folderPath/$indexFile"

        echo "Folder structure created for $componentName in $folderPath:"
        echo "- $folderPath/$componentName.$fileExtensions"
        echo "- $folderPath/$componentName.module.scss"
        echo "- $folderPath/$indexFile"
    fi
done
