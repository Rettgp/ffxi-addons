#!/usr/bin/env python3
"""
Scrape NMs from FFXIclopedia Notorious Monsters Level Guide
"""

import requests
from bs4 import BeautifulSoup
import re
import json


def scrape_nm_list():
    url = "https://ffxiclopedia.fandom.com/wiki/Notorious_Monsters:_Level_Guide"

    # Use a proper user agent to avoid being blocked
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
    }

    print(f"Fetching {url}...")
    response = requests.get(url, headers=headers, timeout=30)
    response.raise_for_status()

    soup = BeautifulSoup(response.content, "html.parser")

    nms = []

    # Find all tables in the page
    tables = soup.find_all("table", {"class": "horizon-table"})
    if not tables:
        tables = soup.find_all("table")

    print(f"Found {len(tables)} tables")

    for table in tables:
        rows = table.find_all("tr")

        for row in rows:
            cells = row.find_all("td")

            # Table structure: Name | Level | Zone | Family | Notable Drop(s)
            if len(cells) >= 4:
                # Extract NM name from first cell
                nm_name = cells[0].get_text(strip=True)

                # Skip headers and empty rows
                if not nm_name or nm_name.lower() in ["name", "notorious monster", ""]:
                    continue

                # Level is in second cell (index 1)
                level_text = cells[1].get_text(strip=True)
                # Extract first number from level (handles "9 - 10" -> "9")
                level_match = re.search(r"(\d{1,3})", level_text)
                level = level_match.group(1) if level_match else "??"

                # Zone is in third cell (index 2)
                zone = cells[2].get_text(strip=True) if len(cells) > 2 else "Unknown"

                # Family is in fourth cell (index 3)
                family = cells[3].get_text(strip=True) if len(cells) > 3 else "Unknown"

                nm_data = {
                    "name": nm_name,
                    "zone": zone,
                    "level": level,
                    "family": family,
                }

                nms.append(nm_data)

    return nms


def main():
    try:
        nms = scrape_nm_list()

        print(f"\nScraped {len(nms)} NMs from FFXIclopedia")

        # Save to JSON for inspection
        with open("nms_scraped.json", "w") as f:
            json.dump(nms, f, indent=2)
        print(f"Saved data to nms_scraped.json")

    except Exception as e:
        print(f"Error: {e}")
        import traceback

        traceback.print_exc()


if __name__ == "__main__":
    main()
