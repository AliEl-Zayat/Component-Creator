---

# Component Creator

This script streamlines the creation of React components with customizable features based on user input.

## Overview

This script enables the effortless generation of React components in a specified directory. It prompts users for a component name and offers an optional flag (-ui) to create a React component structure. It generates the following files:

- `{ComponentName}.tsx`: React component file with a basic structure
- `{ComponentName}.module.scss`: Corresponding SCSS module file
- `index.ts`: Export file

## Usage

1. Run the script.
2. Input the desired component name when prompted.
3. Optionally, append `-ui` to create a UI-specific folder for the component.

### Example Usage:

```bash
# Run the script
./component_creator.sh

# Input the component name
Enter component name (or 'exit' to quit): MyComponent

# Optionally, add -ui flag for a UI-specific component
Enter component name (or 'exit' to quit): MyUIComponent -ui
```

## Instructions

- When prompted for the component name, use a name without spaces.
- Optionally add `-ui` to create a UI-specific folder for the component.

### Folder Structure

```
{outputPath}/{ComponentName}/
├── {ComponentName}.tsx
├── {ComponentName}.module.scss
└── index.ts
```

---
