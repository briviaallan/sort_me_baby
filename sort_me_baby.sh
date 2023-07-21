#!/bin/bash

# Function to extract commonalities from video titles
get_commonality() {
    local file_name="$1"

    # Extract commonalities from the file name using a flexible regular expression
    # Customize this part based on your specific requirements and variations
    commonality=$(echo "$file_name" | grep -oEi "season[[:space:]]*[0-9]+|s[[:space:]]*[0-9]+|ep[[:space:]]*[0-9]+|e[[:space:]]*[0-9]+")
    echo "$commonality"
}

# Function to move the file to the appropriate subfolder
move_to_subfolder() {
    local file_name="$1"
    local category="$2"
    local action="$3"
    local dest_path="$4"

    # Get the commonality from the file name
    commonality=$(get_commonality "$file_name")

    # Choose the destination folder based on the category and commonality
    dest_folder="$dest_path/$category/$commonality"

    # Create the destination folder if it doesn't exist
    if [ ! -d "$dest_folder" ]; then
        mkdir -p "$dest_folder"
    fi

    # Move or copy the file to the subfolder based on user input
    if [ "$action" == "move" ]; then
        # Check if the file already exists in the destination folder
        if [ -f "$dest_folder/$(basename "$file_name")" ]; then
            # Check if the files are identical
            if cmp -s "$file_name" "$dest_folder/$(basename "$file_name")"; then
                echo "File '$(basename "$file_name")' already exists and is identical. Skipping..."
                return
            else
                # Files are not identical, prompt to overwrite
                echo "File '$(basename "$file_name")' already exists in the destination folder."
                echo "Size of the existing file: $(du -h "$dest_folder/$(basename "$file_name")" | cut -f 1)"
                echo "Size of the new file: $(du -h "$file_name" | cut -f 1)"
                echo "Do you want to overwrite the existing file? (Type 'yes' or 'no' and press Enter)"
                read overwrite
                if [ "$overwrite" != "yes" ]; then
                    echo "File '$(basename "$file_name")' was not moved."
                    return
                fi
            fi
        fi
        mv "$file_name" "$dest_folder"
    elif [ "$action" == "copy" ]; then
        # Use rsync with --progress to copy the file and monitor progress
        rsync --progress "$file_name" "$dest_folder"
    fi
}

# Function to traverse subdirectories and sort files
sort_files() {
    local directory="$1"
    local action="$2"
    local dest_path="$3"

    local subdirs=$(find "$directory" -maxdepth 1 -type d)

    # Process files in the current directory
    for file_name in "$directory"/*; do
        if [ -f "$file_name" ]; then
            move_to_subfolder "$file_name" "$action" "$dest_path"
        fi
    done

    # Recursively process subdirectories
    for subdir in $subdirs; do
        sort_files "$subdir" "$action" "$dest_path"
    done
}

# Function to ask for user or root permission
ask_for_permission() {
    echo "Do you want to run the script with elevated privileges (root)? (Type 'yes' or 'no' and press Enter)"
    read use_sudo
    if [ "$use_sudo" == "yes" ]; then
        echo "Please enter your password to run the script with elevated privileges:"
        sudo echo "Thank you! You have elevated privileges to run the script."
    else
        echo "You will be running the script without elevated privileges."
    fi
}

# Prompt the user to enter the source folder
echo "Enter the source folder path and press Enter:"
read SOURCE_DIR

# Validate the source folder path
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Invalid source folder path. Please provide a valid path."
    exit 1
fi

# Prompt the user to enter the destination folder
echo "Enter the destination folder path and press Enter:"
read DEST_DIR

# Validate the destination folder path and create it if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
fi

# Check if elevated privileges (root) are required for certain operations
need_sudo=false
source_drive=$(df -P "$SOURCE_DIR" | awk 'NR==2 {print $1}')
dest_drive=$(df -P "$DEST_DIR" | awk 'NR==2 {print $1}')

if [ "$source_drive" != "$dest_drive" ]; then
    # Different drives/partitions, need elevated privileges for 'move' operation
    need_sudo=true
fi

# Ask for user or root permission if needed
if [ "$need_sudo" == true ]; then
    ask_for_permission
fi

# Ask the user whether to perform a multi-destination transfer
echo "Do you want to perform a multi-destination transfer? (Type 'yes' or 'no' and press Enter)"
read multi_dest_option

if [ "$multi_dest_option" == "yes" ]; then
    # Multi-destination transfer: Ask the user to write down multiple destination directories
    destinations=()
    while true; do
        echo "Enter a destination directory path or type 'done' if finished:"
        read dest_path
        if [ "$dest_path" == "done" ]; then
            break
        fi
        if [ ! -d "$dest_path" ]; then
            echo "Invalid destination folder path. Please provide a valid path."
        else
            destinations+=("$dest_path")
        fi
    done

    # Parallelize processing using GNU Parallel
    parallel --no-notice -k "sort_files $SOURCE_DIR copy {}" ::: "${destinations[@]}"
else
    # Single-destination transfer: Ask the user whether to move or copy the files
    echo "Do you want to move or copy the files? (Type 'move' or 'copy' and press Enter)"
    read action

    # Validate the user input for copy or move option
    if [ "$action" != "move" ] && [ "$action" != "copy" ]; then
        echo "Invalid option. Please enter 'move' or 'copy'."
        exit 1
    fi

    # Call the function to sort files in the source directory and its subdirectories
    echo "Sorting files..."
    sort_files "$SOURCE_DIR" "$action" "$DEST_DIR"
fi

# Optional: Print a message when the sorting is complete
echo "Files sorted into appropriate folders."

