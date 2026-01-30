import os
import re
import json

MANIFEST_PATH = os.path.join(".", "manifest.json")

manifest = {"addons": {}}

for folder in os.listdir("."):
    folder_path = os.path.join(".", folder)
    if os.path.isdir(folder_path):
        lua_file = os.path.join(folder_path, f"{folder}.lua")
        if os.path.isfile(lua_file):
            with open(lua_file, "r", encoding="utf-8") as f:
                content = f.read()
                match = re.search(r"_addon\.version\s*=\s*['\"]([\d\.]+)['\"]", content)
                if match:
                    version = match.group(1)
                    manifest["addons"][folder] = {
                        "version": version
                    }

with open(MANIFEST_PATH, "w", encoding="utf-8") as f:
    json.dump(manifest, f, indent=4)

print(f"Manifest written to {MANIFEST_PATH}")
