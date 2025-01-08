#!/bin/bash

# 将水源文档的 admonitions 格式转换为 mkdocs-material 主题

OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "Darwin" ]]; then
    SED="sed -i ''"
elif [[ "$OS_TYPE" == "Linux" ]]; then
    SED="sed -i"
else
    echo "Unsupported OS: $OS_TYPE"
    exit 1
fi

file_list=(
    "md-handson-notes.md"
    "dft-handson-notes.md"
)

for file in "${file_list[@]}"; do
  if grep -q ":::" "$file"; then
      SED 's/:::danger/!!! danger ""/g' "$file"
      SED 's/:::info/!!! info ""/g' "$file"
      SED 's/:::warning/!!! warning ""/g' "$file"
      SED 's/:::success/!!! success ""/g' "$file"

      SED 's/::://g' "$file"

      SED '' '/!!!/ {
          N
          s/\n/\n\n    /
      }' "$file"

      echo "adolitions format has been converted to mkdocs-material format."
  else
      echo "No need"
  fi
done