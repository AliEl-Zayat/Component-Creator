
---

# Component Creator

This script facilitates the generation of React components with customizable features based on user input.

## Overview

This script prompts users to input a component name and, optionally, a flag (-ui) to create a React component structure in a specified directory. It generates the following files:

- `{ComponentName}.tsx`: React component file with basic structure
- `{ComponentName}.module.scss`: Associated SCSS module file
- `index.ts`: Export file

## Usage

1. Run the script.
2. Enter the desired component name when prompted.
3. Optionally, append `-ui` to create a UI-specific folder for the component.

### Example Usage:

```bash
# Run the script
./component_creator.sh

# Enter component name
Enter component name (or 'exit' to quit): MyComponent

# Optionally add -ui flag for UI-specific component
Enter component name (or 'exit' to quit): MyUIComponent -ui
```

## Instructions

- When prompted for the component name, input a name without spaces.
- Optionally add `-ui` to create a UI-specific folder for the component.

### Folder Structure

```
{outputPath}/{ComponentName}/
├── {ComponentName}.tsx
├── {ComponentName}.module.scss
└── index.ts
```

---

Feel free to add more sections or details if needed. This README gives users a quick overview of what the script does, how to use it, and what to expect from the generated component structure.