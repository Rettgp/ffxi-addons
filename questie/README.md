# Questie - FFXI Quest & Mission Tracker

A comprehensive addon for Final Fantasy XI (Windower) that helps you track your progress through quests and missions with a clean, intuitive interface.

## Features

- ✅ Track multiple quests and missions simultaneously
- ✅ Checkbox system to mark completed steps
- ✅ Persistent progress (saves across game sessions)
- ✅ Collapsible quest interface for better organization
- ✅ Quest search functionality
- ✅ Character-specific save files
- ✅ Visual progress indicators
- ✅ Support for both quests and missions

## Installation

1. Place the `questie` folder in your Windower4/addons directory
2. Load the addon in-game: `//lua load questie`
3. (Optional) Add to your Windower init.txt to auto-load

## Usage

### Commands

- `//questie` or `//quest` - Toggle UI window
- `//questie show` - Show UI window
- `//questie hide` - Hide UI window
- `//questie add <quest_id>` - Add a quest by ID
- `//questie remove <quest_id>` - Remove a quest by ID
- `//questie list` - List all active quests in chat
- `//questie search <name>` - Search for quests by name
- `//questie reload` - Reload quest database
- `//questie save` - Manually save state
- `//questie help` - Show all commands

### Using the UI

1. Click **"Add Quest"** button to open the quest selection popup
2. Select a quest or mission from the list to start tracking it
3. Click the checkboxes next to each step as you complete them
4. Click the collapse arrow to hide/show quest steps
5. Use **"Remove Quest"** button to stop tracking a completed quest

## Quest Database

The addon uses `quest_database.json` to store all quest information. The database currently includes sample quests from:

- San d'Oria
- Bastok
- Windurst
- Jeuno

### Adding More Quests

Edit `quest_database.json` to add more quests. Format:

```json
{
  "id": "unique_quest_id",
  "name": "Quest Name",
  "type": "quest",
  "location": "City/Zone",
  "repeatable": false,
  "steps": ["Step 1 description", "Step 2 description", "Step 3 description"]
}
```

### Data Sources for Quests

You can find comprehensive quest information on:

- [FFXIClopedia](https://ffxiclopedia.fandom.com)
- [BG Wiki](https://www.bg-wiki.com)
- [FFXI Wiki](https://ffxiwiki.org)

## File Structure

```
questie/
├── questie.lua              # Main addon file
├── quest_database.lua       # Database loading and access
├── quest_database.json      # Quest data (edit to add more quests)
├── state.lua               # Progress tracking and persistence
├── ui.lua                  # ImGui interface
├── README.md               # This file
└── data/                   # Character-specific save files
    └── CharacterName_state.json
```

## Progress Persistence

Your quest progress is automatically saved:

- When you complete/uncomplete a step
- When you add/remove a quest
- When you logout
- When you unload the addon

Save files are character-specific and stored in the `data/` folder.

## Tips

- Keep only actively pursued quests tracked for better organization
- Use the collapse feature to hide quests you're not currently working on
- The search function helps you quickly find quests in the database
- Progress percentages show at a glance how close you are to completion

## Future Enhancements

Possible additions:

- Auto-detection of quest completion via game events
- Quest reward information
- Prerequisites and requirements display
- Zone-based quest filtering
- Import quests from online databases
- Quest categories and filtering

## Credits

- Author: Rett
- Version: 1.0
- Built for Windower 4

## License

Free to use and modify for personal use.
