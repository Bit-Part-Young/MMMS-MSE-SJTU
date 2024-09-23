#!/bin/bash

find docs -type f -name "*.md" ! -name "index.md" ! -name "changelog.md" ! -name "links.md" ! -name "mkdocs-test.md" | wc -l

