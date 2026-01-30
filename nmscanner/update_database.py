#!/usr/bin/env python3
"""
Update nm_database.lua with scraped NMs, avoiding duplicates
"""

import json
import re

# Read the scraped NMs
with open("nms_scraped.json", "r") as f:
    scraped_nms = json.load(f)

# Read existing nm_database.lua
with open("nm_database.lua", "r") as f:
    lua_content = f.read()

# Extract existing NM names (case-insensitive)
existing_names = {}
for match in re.finditer(
    r'add_nm\("([^"]+)",\s*"([^"]+)",\s*(\d+),\s*"([^"]+)"\)', lua_content
):
    name = match.group(1)
    existing_names[name.lower()] = {
        "name": name,
        "zone": match.group(2),
        "level": match.group(3),
        "family": match.group(4),
    }

print(f"Total scraped NMs: {len(scraped_nms)}")
print(f"Existing NMs in database: {len(existing_names)}")

# Collect all NMs (existing + new)
all_nms = {}

# Add existing NMs
for name_lower, data in existing_names.items():
    all_nms[name_lower] = data

# Add new NMs from scraped data
new_count = 0
for nm in scraped_nms:
    name_lower = nm["name"].lower()
    if name_lower not in all_nms:
        all_nms[name_lower] = {
            "name": nm["name"],
            "zone": nm["zone"],
            "level": nm["level"],
            "family": nm["family"],
        }
        new_count += 1

print(f"New NMs to add: {new_count}")
print(f"Total NMs after merge: {len(all_nms)}")

# Sort by level
all_nms_list = sorted(
    all_nms.values(),
    key=lambda x: int(x["level"]) if str(x["level"]).isdigit() else 999,
)

# Find where to insert new NMs (before the "Helper functions" section)
insert_pos = lua_content.find("-- Helper functions")
if insert_pos == -1:
    insert_pos = lua_content.find("function nm_database.is_nm")

if insert_pos == -1:
    print("ERROR: Could not find insertion point")
    exit(1)

# Get the header part (everything before add_nm calls but including the add_nm function definition)
header_end = lua_content.find("add_nm(")
# Find the actual function definition
func_def_start = lua_content.find("local function add_nm(")
if func_def_start != -1 and func_def_start < header_end:
    # Include everything up to and including the function definition
    func_def_end = lua_content.find("end", func_def_start) + 3  # +3 for "end"
    # Find the next newline after "end"
    next_newline = lua_content.find("\n", func_def_end)
    header = lua_content[: next_newline + 1] + "\n"
else:
    # Fallback if we can't find the function definition
    header = lua_content[:header_end]

# Get the footer part (helper functions)
footer = lua_content[insert_pos:]

# Generate new add_nm calls organized by level
nm_lines = []
current_section = None

for nm in all_nms_list:
    level = int(nm["level"]) if str(nm["level"]).isdigit() else 99

    # Create sections
    if level < 20:
        section = "Low Level (1-20)"
    elif level < 40:
        section = "Mid Level (20-40)"
    elif level < 60:
        section = "High Level (40-60)"
    elif level < 75:
        section = "Endgame (60-75)"
    elif level < 90:
        section = "Level 75 Era (75-90)"
    elif level < 100:
        section = "Level 99 Content (90-99)"
    else:
        section = "High Level Content (99+)"

    if current_section != section:
        if nm_lines:
            nm_lines.append("")
        nm_lines.append(f"-- {section}")
        current_section = section

    # Escape any quotes
    name = nm["name"].replace('"', '\\"').replace("'", "\\'")
    zone = nm["zone"].replace('"', '\\"').replace("'", "\\'")
    family = nm["family"].replace('"', '\\"').replace("'", "\\'")

    nm_lines.append(f'add_nm("{name}", "{zone}", {nm["level"]}, "{family}")')

# Combine everything
new_content = header + "\n".join(nm_lines) + "\n\n" + footer

# Write back
with open("nm_database.lua", "w") as f:
    f.write(new_content)

print(f"\n✓ Updated nm_database.lua successfully!")
print(f"  Total NMs in database: {len(all_nms)}")
print(f"  New NMs added: {new_count}")
