#!/bin/bash

# Check if an old package name was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <old-package-name>"
    exit 1
fi

# Assign command line argument to variable for the old package name
old_package_name="$1"

# Derive the new package name from the directory the script is located in
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
new_package_name=$(basename "$script_dir")

# Echo the old and new package names
echo "Old package name: $old_package_name"
echo "New package name: $new_package_name"

# Update Flutter package names in pubspec.yaml
echo "Updating Flutter package names in pubspec.yaml files..."
find "$script_dir" -type f -name "pubspec.yaml" -exec sh -c '
  sed -i.bak "s/^name:.*/name: $1/" "$2" && echo "Updated $2" && rm "$2.bak"
' _ "$new_package_name" {} \;

# Update Flutter package imports in Dart files within the /lib directory
echo "Updating Flutter package imports in Dart files..."
lib_path="${script_dir}/lib"
if [ -d "$lib_path" ]; then
    find "$lib_path" -type f -name "*.dart" -exec sh -c '
      sed -i.bak "s/package:$2\//package:$1\//g" "$3" && echo "Updated $3" && rm "$3.bak"
    ' _ "$new_package_name" "$old_package_name" {} \;
fi

# Inform user of success
echo "The files have been cleaned to use packages matching $new_package_name"
