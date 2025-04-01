import os

def rename_files(file_dir, names_file):
    """Renames files in file_dir based on names in names_file."""

    # 1. Preprocess the names file into a hash map
    name_map = {}
    try:
        with open(names_file, 'r') as f:
            for line in f:
                parts = line.strip().split('--')
                if len(parts) > 1:
                    name_map[parts[0]] = line.strip()
    except FileNotFoundError:
        print(f"Error: File '{names_file}' not found.")
        return

    # 2. Iterate through files and use hash map lookup
    try:
        for filename in os.listdir(file_dir):
            if filename.endswith(".pdf"):
                file_base = os.path.splitext(filename)[0]  # Remove extension
                full_path = os.path.join(file_dir, filename)

                if file_base in name_map:
                    new_name = name_map[file_base] + ".pdf"
                    new_path = os.path.join(file_dir, new_name)
                    os.rename(full_path, new_path)
                    print(f"Renamed '{filename}' to '{new_name}'")
    except FileNotFoundError:
        print(f"Error: Directory '{file_dir}' not found.")
        return

# Example usage:
file_dir = "/home/mcc/Desktop/AllPDFs/"
names_file = "1.PDF.subjects.txt"
rename_files(file_dir, names_file)
