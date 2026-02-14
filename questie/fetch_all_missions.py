#!/usr/bin/env python3
"""
Fetch all Seekers of Adoulin missions from bg-wiki.
"""

import sys
import time
import re
from bs4 import BeautifulSoup
from mission_scraper import scrape_mission


# List of all SoA missions based on the provided list
MISSIONS = [
"1-1",
"1-2",
"1-3",
"2-1",
"2-2",
"2-3",
"3-1",
"3-2",
"3-3",
"4-1",
"5-1",
"5-2",
"6-1",
"6-2",
"7-1",
"7-2",
"8-1",
"8-2",
"9-1",
"9-2"
]
EXPANSION_NAME = "Windurst"


def extract_walkthrough_steps(html):
    """Extract walkthrough steps from mission HTML."""
    soup = BeautifulSoup(html, "html.parser")

    # Find the Walkthrough section
    walkthrough_header = None
    for header in soup.find_all(["h2", "h3", "span"]):
        header_text = header.get_text(strip=True)
        if header_text in ["Walkthrough", "Walkthrough:"]:
            walkthrough_header = header
            break

    if not walkthrough_header:
        return []

    # Collect all content until the next header
    steps = []

    # Find the parent that contains the walkthrough content
    parent = walkthrough_header.find_parent(["div", "section"])
    if parent:
        # Look for lists and paragraphs within this section
        for elem in parent.find_all(["ul", "ol", "p"], recursive=True):
            if elem.name in ["ul", "ol"]:
                for li in elem.find_all("li", recursive=False):
                    text = li.get_text(separator=" ", strip=True)
                    # Clean up the text
                    text = re.sub(r"\s+", " ", text)
                    if text and len(text) > 5:
                        steps.append(text)
            elif elem.name == "p":
                text = elem.get_text(separator=" ", strip=True)
                text = re.sub(r"\s+", " ", text)
                if text and len(text) > 10:
                    # Skip if it's just a header or navigation
                    if (
                        not text.startswith("Retrieved from")
                        and "Category:" not in text
                    ):
                        steps.append(text)

    # Alternative: look for the next siblings after the header
    if not steps:
        current = walkthrough_header.find_next_sibling()
        while current and current.name not in ["h2", "h3"]:
            if current.name in ["ul", "ol"]:
                for li in current.find_all("li", recursive=False):
                    text = li.get_text(separator=" ", strip=True)
                    text = re.sub(r"\s+", " ", text)
                    if text and len(text) > 5:
                        steps.append(text)
            elif current.name == "p":
                text = current.get_text(separator=" ", strip=True)
                text = re.sub(r"\s+", " ", text)
                if text and len(text) > 10:
                    steps.append(text)
            current = current.find_next_sibling()

    return steps


def get_mission_name(html):
    """Extract mission name from HTML."""
    soup = BeautifulSoup(html, "html.parser")

    # Try to find the page title
    title_tag = soup.find("h1", {"class": "firstHeading"})
    if title_tag:
        title = title_tag.get_text(strip=True)
        title = re.sub(rf"^\w+ Mission\s+\d+-\d+(-\d+)?:?\s*", "", title)
        return title

    return None


def main():
    """Fetch all missions."""

    base_url = "https://www.bg-wiki.com/ffxi/Windurst_Mission_{}"
    output_file = "windurst_missions.lua"

    results = []

    for i, mission_id in enumerate(MISSIONS):
        url = base_url.format(mission_id)

        print(f"[{i+1}/{len(MISSIONS)}] Fetching {mission_id}...", file=sys.stderr)

        try:
            html = scrape_mission(url)

            # Check if it's a valid page
            if (
                "does not have an article" in html
                or "There is currently no text" in html
            ):
                print(f"  ⚠ Mission {mission_id} page does not exist", file=sys.stderr)
                continue

            print(f"  ✓ Successfully fetched {mission_id}", file=sys.stderr)
            name = get_mission_name(html)
            steps = extract_walkthrough_steps(html)

            if not name:
                print(f"  ⚠ Could not extract name for {mission_id}", file=sys.stderr)
                name = f"Mission {mission_id}"

            if not steps:
                print(
                    f"  ⚠ No walkthrough steps found for {mission_id}", file=sys.stderr
                )

            results.append({"id": mission_id, "name": name, "steps": steps})

            print(f"  ✓ {name} ({len(steps)} steps)", file=sys.stderr)

            # Be respectful to the server
            time.sleep(2)

        except Exception as e:
            print(f"  ✗ Error fetching {mission_id}: {e}", file=sys.stderr)
            continue

    # Write to Lua file
    print(f"\nWriting {len(results)} missions to {output_file}...", file=sys.stderr)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write("-- Missions\n")
        f.write("-- Auto-generated from bg-wiki\n\n")
        f.write("local missions = {\n")

        for i, mission in enumerate(results):
            lua_id = mission["id"].replace("-", "_")
            f.write("    {\n")
            f.write(f'      id = "mission_windurst_{lua_id}",\n')
            f.write(f'      name = "{mission["name"]}",\n')
            f.write('      type = "mission",\n')
            f.write(f'      location = "{EXPANSION_NAME.lower().replace(" ", "_")}",\n')
            f.write(f'      nation = "{EXPANSION_NAME.lower().replace(" ", "_")}",\n')
            f.write(f"      mission_index = {i + 1},\n")
            f.write(f"      game_id = {0},\n")
            f.write("      repeatable = false,\n")
            f.write("      steps = {\n")
            for step in mission["steps"]:
                # Escape quotes and clean up
                step_clean = (
                    step.replace("\\", "\\\\").replace('"', '\\"').replace("\n", " ")
                )
                # Remove excessive whitespace
                step_clean = re.sub(r"\s+", " ", step_clean).strip()
                f.write(f'        "{step_clean}",\n')
            f.write("      }\n")
            f.write("    },\n")

        f.write("}\n\n")
        f.write("return missions\n")

    print(
        f"✓ Successfully wrote {len(results)} missions to {output_file}",
        file=sys.stderr,
    )


if __name__ == "__main__":
    main()
