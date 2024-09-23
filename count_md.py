import os
from glob import glob


def count_md_files(directory: str) -> int:
    """统计 md 文件数目"""
    md_file_list = glob(os.path.join(directory, "**/*.md"), recursive=True)

    filtered_md_files = [
        f
        for f in md_file_list
        if os.path.basename(f)
        not in ["index.md", "links.md", "changelog.md", "mkdocs-test.md"]
    ]

    return len(filtered_md_files)


directory_path = "docs"
md_files_count = count_md_files(directory_path)
print(f"md files count: {md_files_count}.")
