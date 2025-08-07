# create symlink to <color>.css

# arguments:
# $1: color_file
# $2: path to destination directory
# $3: copy file instead of symlink (optional)

color_file="$1"
dest_dir="$2"

if [[ -z "$color_file" || -z "$dest_dir" ]]; then
    echo "Usage: create_symlink <color_file> <destination_directory>"
    exit 1
fi

dest_file="${dest_dir}/t3.chat.css"

if [[ ! -f "$color_file" ]]; then
    echo "Error: Color file '$color_file' does not exist."
    exit 1
fi

color_file=$(realpath "$color_file")

if [[ $3 == "-c" ]]; then
    echo "Copying file instead of creating symlink..."

    # check if dest_file points to a symlink of color_file
    if [[ -L "$dest_file" && "$(readlink "$dest_file")" == "$color_file" ]]; then
        echo "Removing existing symlink..."

        rm "$dest_file"
        
        if [[ $? -ne 0 ]]; then
            echo "Error: Failed to remove existing symlink."
            exit 1
        fi
    fi

    cp "$color_file" "$dest_file"

    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to copy file."
        exit 1
    fi
    dest_file=$(realpath "$dest_file")
    echo "Copied file to: $dest_file"
else
    echo "Creating symlink..."

    ln -sf "$color_file" "$dest_file"

    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to create symlink."
        exit 1
    fi
    dest_file=$(realpath "$dest_file")
    echo "Created symlink: $dest_file -> $color_file"
fi

