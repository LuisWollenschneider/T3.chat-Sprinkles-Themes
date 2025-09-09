OUTPUT_DIR="combinations"

themes=("$@")

if [ ${#themes[@]} -eq 0 ]; then
  echo "No themes provided. Please specify at least one theme."
  exit 1
fi
if [[ ${#themes[@]} -gt 4 ]]; then
    echo "Error: Too many themes provided. Please specify up to 4 themes."
    exit 1
fi

valid_themes=("dark" "boring-dark" "light" "boring-light")
used_themes=()
files_to_join=()
# check if themes are valid css files
for theme in "${themes[@]}"; do
    if [[ ! -f "$theme.css" && ! -f "$theme" ]]; then
        echo "Error: Theme '$theme' does not exist."
        exit 1
    fi

    theme="${theme%.css}"  # remove .css extension if present
    theme="${theme}.css"  # ensure it has .css extension

    theme_path=$(realpath "$theme")
    # get last level directory name
    theme_dir=$(basename "$(dirname "$theme_path")")

    if [[ ! " ${valid_themes[*]} " =~ " $theme_dir " ]]; then
        echo "Error: Theme '$theme_dir' is not a valid theme directory."
        exit 1
    fi
    used_themes+=("$theme_dir")
    files_to_join+=("$theme_path")
done

# remove duplicates
used_themes=($(echo "${used_themes[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

# check length of used_themes
if [[ ${#used_themes[@]} -lt ${#themes[@]} ]]; then
    echo "Error: Some themes are duplicates or not valid."
    exit 1
fi

# sort files_to_join
IFS=$'\n' files_to_join=($(sort <<<"${files_to_join[*]}"))
unset IFS

file_name=""

echo "Themes to combine:"
for theme in "${files_to_join[@]}"; do
    theme_name=$(realpath "$theme")
    dir_name="$(basename "$(dirname "$theme_name")")"
    theme_name=$(basename "$theme_name")
    theme_name="${theme_name%.css}"
    fn=""

    # contains "boring" in the name
    if [[ "$dir_name" == *"boring"* ]]; then
        fn+="b"
    fi

    if [[ "$dir_name" == *"dark"* ]]; then
        fn+="d"
    elif [[ "$dir_name" == *"light"* ]]; then
        fn+="l"
    fi

    fn+="-${theme_name}"
    echo "- $dir_name/$theme_name.css (as $fn)"

    file_name+="${fn}_"
done

echo ""
file_name="${file_name%_}"  # remove trailing underscore

OUTPUT_FILE="${OUTPUT_DIR}/${file_name}.css"

echo "" > "$OUTPUT_FILE"  # clear the output file
for theme in "${files_to_join[@]}"; do
    # dir/file_name.css
    theme_name=$(realpath "$theme")
    dir_name="$(basename "$(dirname "$theme_name")")"
    theme_name=$(basename "$theme_name")
    theme_name="${theme_name%.css}"  # remove .css extension if present
    echo "/* Theme: $dir_name/$theme_name.css */" >> "$OUTPUT_FILE"
    cat "$theme" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

echo "Combined themes into: $OUTPUT_FILE"