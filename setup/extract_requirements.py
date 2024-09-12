#!/usr/bin/env python
import json


def main():
    with open("pip_inspect.json") as fh:
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

    for module, reqs in modules.items():
        print(f"# {module}")
        for req in reqs:
            print(req)
        print()


if __name__ == "__main__":
    main()
