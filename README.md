# HaloScript Collection

A repository of `.hsc` (HaloScript) files and tools designed for **Halo: The Master Chief Collection** Editing Kits. This collection includes logic for multiplayer gametypes, scenario-specific events, and utility scripts for map development using the Halo Editing Kit (HEK).

## Repository Structure

The scripts are organized by their specific function within the Blam engine:

*   **Multiplayer Logic:** 
    *   `/Ctf`: Scripts governing Capture the Flag logic.
    *   `/King`: Logic for King of the Hill.
    *   `/Oddball`: Ball-tracking and scoring scripts.
    *   `/Race`: Checkpoint and lap-tracking logic.
    *   `/Slayer`: Death-matching and scoring overrides.
*   **Scenario Scripts:** Logic designed for specific level encounters, AI triggers, and campaign-style mission flow.
*   **Shared:** Common functions and global variables used across multiple gametypes or scenarios.
*   **Tag-Export-Tools:** Specialized scripts and snippets designed to assist in exporting or managing data within the HEK environment.

## Prerequisites

To use these scripts, you need:
1.  **Halo: Combat Evolved (PC)** or **Halo: MCC**.
2.  **Halo Editing Kit (HEK)** or **MCC Mod Tools**.
3.  **Sapien** (the world editor) or **Tool.exe** for script compilation.

## How to Use

### 1. File Placement
HaloScript files must be placed in the `data` directory of your Halo installation for the compiler to find them:
`.../HCE/data/levels/[your_level_name]/scripts/`

### 2. Compilation
The game does not read `.hsc` files at runtime; they must be compiled into the scenario:
1.  Place the desired script in the folder mentioned above.
2.  Open your map's `.scenario` file in **Sapien**.
3.  The scripts will compile automatically on load. 
4.  Check the **External Console** for errors. If the console reports `Scripts compiled successfully`, the logic is now embedded in your scenario.

### 3. Using Shared Scripts
If using files from the `/Shared` folder, ensure they are included or copied into your level-specific script file to avoid "undefined identifier" errors during compilation.

## Script Types Reference

When browsing the files in this repo, you will encounter these common script types:
*   `startup`: Runs once when the map loads.
*   `continuous`: Runs every tick (30 times per second). Use with caution for performance.
*   `dormant`: Does nothing until "woken up" by another script.
*   `static`: A reusable function or "method" that can be called by other scripts.

## Contributing
This is an archive of legacy material. We are not looking for new contributions.


## ⚠️ Disclaimer
These scripts are intended for use with the Halo Editing Kit(s). Always back up your `.scenario` and `.hsc` files before performing major edits. Incorrect logic in `continuous` scripts can cause "Script Overflow" errors or game crashes.

---
*Maintained by [Tzeentchnet](https://github.com/Tzeentchnet).*
