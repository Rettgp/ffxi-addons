#!/usr/bin/env python3
"""
Generic mission scraper for FFXI bg-wiki pages.
Handles HTTP 429 errors with exponential backoff.
"""

import sys
import time
import requests
from urllib.parse import urlparse


def scrape_mission(url, max_retries=5, initial_delay=1):
    """
    Scrape a mission page from bg-wiki.

    Args:
        url: The URL to scrape
        max_retries: Maximum number of retry attempts for 429 errors
        initial_delay: Initial delay in seconds before first retry

    Returns:
        str: The HTML content of the page

    Raises:
        requests.exceptions.RequestException: If the request fails after all retries
    """
    headers = {
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    }

    delay = initial_delay

    for attempt in range(max_retries):
        try:
            response = requests.get(url, headers=headers, timeout=30)

            if response.status_code == 200:
                return response.text
            elif response.status_code == 429:
                if attempt < max_retries - 1:
                    print(
                        f"HTTP 429 (Too Many Requests) - Waiting {delay} seconds before retry {attempt + 1}/{max_retries - 1}...",
                        file=sys.stderr,
                    )
                    time.sleep(delay)
                    delay *= 2  # Exponential backoff
                    continue
                else:
                    raise requests.exceptions.RequestException(
                        f"HTTP 429: Too many requests after {max_retries} attempts"
                    )
            else:
                raise requests.exceptions.RequestException(
                    f"HTTP {response.status_code}: {response.reason}"
                )

        except requests.exceptions.Timeout:
            if attempt < max_retries - 1:
                print(
                    f"Request timeout - Waiting {delay} seconds before retry {attempt + 1}/{max_retries - 1}...",
                    file=sys.stderr,
                )
                time.sleep(delay)
                delay *= 2
                continue
            else:
                raise
        except requests.exceptions.RequestException as e:
            if attempt < max_retries - 1 and "Connection" in str(e):
                print(
                    f"Connection error - Waiting {delay} seconds before retry {attempt + 1}/{max_retries - 1}...",
                    file=sys.stderr,
                )
                time.sleep(delay)
                delay *= 2
                continue
            else:
                raise

    raise requests.exceptions.RequestException(
        f"Failed to retrieve URL after {max_retries} attempts"
    )


def main():
    """Main entry point for the script."""
    if len(sys.argv) != 2:
        print("Usage: mission_scraper.py <url>", file=sys.stderr)
        sys.exit(1)

    url = sys.argv[1]

    # Validate URL
    parsed = urlparse(url)
    if not parsed.scheme or not parsed.netloc:
        print(f"Error: Invalid URL: {url}", file=sys.stderr)
        sys.exit(1)

    try:
        html = scrape_mission(url)
        print(html)
    except requests.exceptions.RequestException as e:
        print(f"Error scraping {url}: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
