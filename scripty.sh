#!/bin/bash

defaultOutputPath="/Users/aliel-zayat/Desktop/Development/PROJECTS/SIDED/DigimileWebApp/src/components" # Set your default output path here

# Ask for the output path if the default isn't provided in the script
if [ -z "$defaultOutputPath" ]; then
    read -p "Enter the default output path: " defaultOutputPath
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
        touch "$folderPath/$componentName.tsx"
        touch "$folderPath/$componentName.module.scss"
        touch "$folderPath/index.ts"

        # Write content to componentName.tsx
        echo "import React from 'react';" > "$folderPath/$componentName.tsx"
        echo "import Styles from './$componentName.module.scss';" >> "$folderPath/$componentName.tsx"
        echo "" >> "$folderPath/$componentName.tsx"
        echo "const $componentName = () => {" >> "$folderPath/$componentName.tsx"
        echo "  return <></>;" >> "$folderPath/$componentName.tsx"
        echo "};" >> "$folderPath/$componentName.tsx"
        echo "" >> "$folderPath/$componentName.tsx"
        echo "export default $componentName;" >> "$folderPath/$componentName.tsx"

        # Write content to index.ts
        echo "export { default } from './$componentName';" > "$folderPath/index.ts"

        echo "Folder structure created for $componentName in $folderPath:"
        echo "- $folderPath/$componentName.tsx"
        echo "- $folderPath/$componentName.module.scss"
        echo "- $folderPath/index.ts"
    fi
done
