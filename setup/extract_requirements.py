#!/usr/bin/env python
"""Extract Python packages installed in software modules.

Run `pip inspect > pip-inspect.json` before calling this script.
"""

import json


def main():
    with open("pip-inspect.json") as fh:
        data = json.load(fh)

    modules = {}
    for package in data["installed"]:
        if package.get("installer") != "pip":
            continue
        name = package["metadata"]["name"]
        version = package["metadata"]["version"]
        location = package["metadata_location"]
        words = location.split("/")
        words = words[: words.index("lib")]
        module = "/".join(words)
        modules.setdefault(module, []).append(f"{name}=={version}")

    for module, reqs in sorted(modules.items()):
        print(f"# {module}")
        for req in sorted(reqs):
            print(req)
        print()


if __name__ == "__main__":
    main()
