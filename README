# T3.chat themes for Sprinkles

This is a collection of themes for [T3.chat](https://t3.chat) that can be used with the [Sprinkles](https://getsprinkles.app) browser extension.

---

These themes are activated for the "boring-dark" mode.

To activate, set your t3.chat theme to "dark" and toggle the "Boring Theme" option in your [t3.chat settings](https://t3.chat/settings/customization) under "Visual Options".

---

## Requirements:
- MacOS
- [Sprinkles](https://getsprinkles.app) browser extension installed.

## How to use:

2 ways to use these themes:

### **Copy and paste the CSS**
1. Choose your desired theme file (e.g., `green.css`, `blue.css`, etc.)
2. Copy the the file to `/path/to/sprinkles/t3.chat.css`

### **Use the setup script**
1. Clone this repository
```sh
git clone https://github.com/LuisWollenschneider/T3.chat-Sprinkles-Themes.git
```
2. Choose your desired theme file (e.g., `green.css`, `blue.css`, etc.)
3. Run the setup script:
```sh
sh setup.sh chosen-theme.css /path/to/sprinkles/ [-c]
```
- By default, a symlink from the Sprinkles directory to the theme file will be created
- The `-c` option will copy the file instead of creating a symlink

---

## Creating a new theme

The colors inside the `.boring-dark` selector are defined as HSL values.

The variables **must** remain in HSL format without the `hsl()` function.

If you want to use e.g. the Visual Studio Code color picker, you have to add the `hsl()` function beforehand.
Feel free to use the `toggle_hsl.py` script to toggle add and remove the `hsl()` function from the variables.
```sh
python3 toggle_hsl.py /path/to/your/theme.css [--add | -a | --remove | -r]
```

---

## Issues

Styles requiring escape sequences within the class names are not applied correctly. 

Example:
```css
.dark\:active\:bg-pink-800\/40:active:is(.boring-dark *) {
    background-color: rgba(23, 157, 30, 0.4) !important;
}
```

This affects the following elements:
| Selector | Description |
| --- | --- |
| `.dark\:active\:bg-pink-800\/40:active:is(.boring-dark *)` | Hovering the "New Chat" Button |
| `.bg-pink-500\/15` | Background of active "Search" query parameter |
| `.dark\:hover\:bg-pink-800\/70:hover:is(.boring-dark *)` | Hovering the selected category within the "New Chat" window |

And similar behavior inside the settings menu.