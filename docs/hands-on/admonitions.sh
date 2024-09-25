#!/bin/bash

# 将水源文档的 admonitions 格式转换为 mkdocs-material 主题

OS_TYPE=$(uname)

FILE_list=(
    "md-handson-notes.md"
    "dft-handson-notes.md"
)

for file in "${FILE_list[@]}"; do
    if [[ "$OS_TYPE" == "Darwin" ]]; then
        if grep -q ':::' "$file"; then
            sed -i '' 's/:::danger/!!! danger ""/g' "$file"
            sed -i '' 's/:::info/!!! info ""/g' "$file"
            sed -i '' 's/:::warning/!!! warning ""/g' "$file"
            sed -i '' 's/:::success/!!! success ""/g' "$file"

            sed -i '' 's/::://g' "$file"

            sed -i '' '/!!!/ {
                N
                s/\n/\n\n    /
            }' "$file"

            echo "$file admonitions format converted to mkdocs-material."
        else 
            echo "No need to convert."
        fi

    elif [[ "$OS_TYPE" == "Linux" ]]; then
        if grep -q ":::" "$file"; then
            sed -i 's/:::danger/!!! danger ""/g' "$file"
            sed -i 's/:::info/!!! info ""/g' "$file"
            sed -i 's/:::warning/!!! warning ""/g' "$file"
            sed -i 's/:::success/!!! success ""/g' "$file"

            sed -i 's/::://g' "$file"

            sed -i '' '/!!!/ {
                N
                s/\n/\n\n    /
            }' "$file"

            echo "adolitions format has been converted to mkdocs-material format."
        else 
            echo "No need"
        fi
    else
        echo "Unsupported OS: $OS_TYPE"
        exit 1
    fi
done