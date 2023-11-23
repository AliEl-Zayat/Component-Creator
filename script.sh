#!/bin/bash

# Ask if user wants to use TypeScript
read -p "Using TypeScript? (Yes/No): " useTypescript

if [[ "$useTypescript" =~ ^[Yy](es)?$ ]]; then
    fileExtensions="tsx"
    indexFile="index.ts"
else
    fileExtensions="jsx"
    indexFile="index.js"
fi

# Prompt user for the directory path
read -p "Enter the directory path: " DIRECTORY_PATH

# Check if the directory exists
if [ ! -d "$DIRECTORY_PATH" ]; then
    echo "Directory does not exist or is invalid."
    exit 1
fi

# Function to create index.js or index.ts based on user selection
create_index_file() {
    INDEX_FILE="$DIRECTORY_PATH/$indexFile"
    echo "" > "$INDEX_FILE"

    # Loop through folders in the directory and generate imports
    for folder in "$DIRECTORY_PATH"/*/; do
        folder_name=$(basename "$folder")
        capitalized_folder_name="$(tr '[:lower:]' '[:upper:]' <<< ${folder_name:0:1})${folder_name:1}"
        echo "import ${capitalized_folder_name} from \"./${folder_name}\"" >> "$INDEX_FILE"
        components+=" ${capitalized_folder_name},"
    done

    # Export components
    echo -n "export {" >> "$INDEX_FILE"
    echo -n "$components" | sed 's/,$//' >> "$INDEX_FILE"
    echo " }" >> "$INDEX_FILE"

    echo "Created $indexFile in $DIRECTORY_PATH"
}

# Main menu
while true; do
    echo "Menu:"
    echo "1. Loop over folders and create index file"
    echo "2. Create React components"
    echo "000. Exit"

    read -p "Select an option: " option

    case "$option" in
        1)
            # Create the index.js or index.ts file
            create_index_file
            ;;
        2)
            while true; do
                read -p "Enter component name (or 'exit' to quit): " userInput

                # Extract the component name and check for -ui flag 
                componentName=$(echo "$userInput" | cut -d' ' -f1)
                isUiFlag=$(echo "$userInput" | grep -o '\-ui')

                # Check if user wants to exit or go back
                if [ "$componentName" == "exit" ]; then
                    echo "Exiting component creation..."
                    break
                elif [ "$componentName" == "000" ]; then
                    echo "Going back to the main menu..."
                    break 2
                fi

                # Check if componentName is provided
                if [ -z "$componentName" ]; then
                    echo "Please provide a component name."
                else
                    # Use default output path
                    outputPath="$DIRECTORY_PATH"

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
            ;;
        000)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
done
