# NM Scanner - FFXI Windower Addon

An advanced Notorious Monster detection system for Final Fantasy XI.

## Features

- **Real-time NM Detection**: Automatically scans the mob array for notorious monsters
- **Comprehensive Database**: Contains 100+ NMs from across all FFXI expansions
- **Enhanced Visual Notifications**: Beautiful bordered UI with color-coded information
  - Family-based color themes (Dragons=Red, Demons=Purple, Sky Gods=Gold, etc.)
  - Rank indicators (★★★ ULTIMATE, ★★ ELITE, ★ DANGEROUS)
  - Distance color coding (Close=Red, Medium=Yellow, Far=Blue)
  - HP bar display with visual progress indicator
  - Pulsing background effect for attention
- **Customizable Themes**: Choose from Dark, Blue, Purple, or Red backgrounds
- **Auto-Centered Display**: Automatically positions in center of screen
- **Distance Filtering**: Only alerts for NMs within configurable range
- **Smart Caching**: Prevents duplicate alerts for the same NM
- **Sound Alerts**: Optional audio notification when NM is detected

## Installation

1. Copy the `nmscanner` folder to your Windower addons directory
2. Load the addon in-game: `//lua load nmscanner`

## Visual Preview

When an NM is detected, you'll see a beautiful notification like this:

```
╔═══════════════════════════════════════════╗
║  ⚠  NOTORIOUS MONSTER DETECTED  ⚠         ║
╠═══════════════════════════════════════════╣
║  Fafnir                                   ║
║  【 ★★ ELITE 】                            ║
╠───────────────────────────────────────────╣
║  Level:    85                             ║
║  Distance: 23.5 yalms                     ║
║  HP:       100%                           ║
╠═══════════════════════════════════════════╣
║  Click to dismiss • Auto-hide in 30s      ║
╚═══════════════════════════════════════════╝
```

- Colors change based on NM family (Dragons=Red, Demons=Purple, etc.)
- Distance shown in color (Close=Red, Far=Blue)
- Rank shown with stars
- Background pulses gently for attention

## Commands

- `//nmscan help` - Display help menu
- `//nmscan toggle` - Enable/disable the scanner
- `//nmscan ui` - Toggle UI notifications on/off
- `//nmscan sound` - Toggle alert sound on/off
- `//nmscan distance <yalms>` - Set maximum alert distance (default: 50)
- `//nmscan theme <dark|blue|purple|red>` - Change UI color theme
- `//nmscan clear` - Clear the detected NM cache
- `//nmscan status` - Show current scanner settings and statistics
- `//nmscan list <name>` - Check if a specific monster is in the NM database

## Configuration

The scanner can be customized through in-game commands:

- **Max Distance**: Set how far away NMs can be detected (default: 50 yalms)
- **Scan Interval**: Automatically scans every 1 second (modifiable in code)
- **UI Display**: Toggle pop-up notifications
- **UI Themes**: Choose background color (dark/blue/purple/red)
- **Sound Alerts**: Toggle audio notifications

## Visual Features

The UI automatically adjusts colors based on the NM:

### Family Colors

- **Dragons** (Fafnir, Tiamat, etc.) - Bright Red
- **Wyrms** (Suzaku, Seiryu, etc.) - Orange
- **Demons** (Dynamis Lord, etc.) - Purple
- **Sky Gods** (Kirin) - Gold
- **Behemoths** - Brown
- **Avatars** - Blue
- And more...

### Rank Indicators

- **★★★ ULTIMATE** - Level 99+
- **★★ ELITE** - Level 85-98
- **★ DANGEROUS** - Level 70-84
- **⚔ NOTORIOUS** - Under 70

### Distance Colors

- **Red** - Very close (< 10 yalms) - Immediate danger!
- **Yellow** - Medium range (10-25 yalms)
- **Blue** - Far (> 25 yalms)

### HP Display

When available, shows a visual HP bar with percentage:

- **Green** - Healthy (> 50%)
- **Yellow** - Wounded (25-50%)
- **Red** - Critical (< 25%)

## NM Database

The addon includes a comprehensive database of notorious monsters including:

- **HNMs**: Fafnir, Nidhogg, Tiamat, Vrtra, Jormungand, King Behemoth
- **Sky Gods**: Kirin, Suzaku, Seiryu, Genbu, Byakko
- **Dynamis Lords**: Dynamis Lord, Arch Dynamis Lord
- **Jailers**: Love, Hope, Faith, Justice, Fortitude, Prudence
- **Limbus**: Proto-Omega, Proto-Ultima, Arch-Omega, Arch-Ultima
- **Zone NMs**: Leaping Lizzy, Valkurm Emperor, Serket, Simurgh, and many more
- **Abyssea NMs**: Briareus, Sobek, Turul, and others
- **Modern Content**: Reisenjima, Omen, Ambuscade NMs

Over 100 NMs are tracked!

## Technical Notes

### Mob Array Integration

The addon includes a stub for mob array access. When you have access to your other computer's codebase, replace the `get_mob_array()` function with the actual Windower mob array access code.

Expected mob data structure:

```lua
{
  name = "Monster Name",
  id = 12345,
  x = 0.0, y = 0.0, z = 0.0,
  distance = 10.5,
  hpp = 100,
  spawn_type = 16,  -- 16 = mob
  model_id = 1234
}
```

## Files

- `nmscanner.lua` - Main addon file with scanning logic
- `nm_database.lua` - Comprehensive NM database
- `ui.lua` - UI notification system

## Future Enhancements

- Custom NM lists/filters
- Alert history log
- Position tracking and mapping
- Claim detection
- Party/Linkshell notifications
- Sound file customization

## Author

Rett

## Version

1.0
