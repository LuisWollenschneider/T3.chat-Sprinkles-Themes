import argparse
import os
import re


def main():
    parser = argparse.ArgumentParser(description="Create a new theme for t3.chat.")
    # positional argument for theme name
    parser.add_argument("name", type=str, help="Name of the theme to toggle hsl.")
    parser.add_argument("-a", "--add", action="store_true", help="Add hsl() to the theme.")
    parser.add_argument("-r", "--remove", action="store_true", help="Remove hsl() from the theme.")
    args = parser.parse_args()

    theme_name = args.name.removesuffix(".css")
    if not theme_name:
        print("Error: Theme name is required.")
        return
    theme_file = theme_name + ".css"

    if not os.path.exists(theme_file):
        print(f"Error: Theme '{theme_file}' not found.")
        return
    
    if args.add and args.remove:
        print("Error: Cannot use both --add and --remove options at the same time.")
        return
    if not args.add and not args.remove:
        print("Error: You must specify either --add or --remove.")
        return
    
    with open(theme_file, "r") as f:
        content = f.readlines()

    with open(theme_file, "w") as f:
        for line in content:
            if args.add:
                # Add hsl() to the theme
                # \d+\.?\d* \d+\.?\d*% \d+\.?\d*% -> hsl(\1, \2, \3)
                line = re.sub(r'(\d+\.?\d*) (\d+\.?\d*%) (\d+\.?\d*%)', r'hsl(\1, \2, \3)', line)
            elif args.remove:
                # Remove hsl() from the theme
                # hsl(\d+\.?\d*, \d+\.?\d*%, \d+\.?\d*%) -> \1 \2 \3
                line = re.sub(r'hsl\((\d+\.?\d*), (\d+\.?\d*%), (\d+\.?\d*%)\)', r'\1 \2 \3', line)
            f.write(line)

    print(f"hsl() {'added to' if args.add else 'removed from'} theme '{theme_file}' successfully.")




if __name__ == "__main__":
    main()