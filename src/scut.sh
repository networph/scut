#!/bin/bash

CURRENT_VERSION="1.0.6"

# Detect the shell environment
if [[ "$SHELL" == */zsh ]]; then
    CONFIG_FILE="$HOME/.zshrc"
    echo "Detected Zsh shell."
elif [[ "$SHELL" == */bash ]]; then
    CONFIG_FILE="$HOME/.bashrc"
    echo "Detected Bash shell."
else
    echo "Unsupported shell. Only Bash and Zsh are supported."
    exit 1
fi

FAVORITES_FILE="$HOME/.scut_favorites"
GITHUB_RAW_BASEURL="https://raw.githubusercontent.com/networph/scut/main"

# Ensure the favorites file exists
touch "$FAVORITES_FILE"

check_for_updates() {
    BASE_URL="https://raw.githubusercontent.com/networph/scut/main/version"
    LATEST_VERSION=$(curl -s -H 'Cache-Control: no-cache' "$BASE_URL" | tr -d 'v' | tr -d ' ')
    
    echo "DEBUG: Current version: $CURRENT_VERSION, Latest version: $LATEST_VERSION"

    if [[ $(echo -e "$CURRENT_VERSION\n$LATEST_VERSION" | sort -V | head -n1) != "$LATEST_VERSION" && "$CURRENT_VERSION" != "$LATEST_VERSION" ]]; then
        echo "A new version of scut is available (v$LATEST_VERSION)."
        
        SCRIPT_URL="https://raw.githubusercontent.com/networph/scut/main/src/scut.sh"
        SCRIPT_PATH="/usr/local/bin/scut"
        curl -s "$SCRIPT_URL" -o "$SCRIPT_PATH"
        
        chmod +x "$SCRIPT_PATH"
        
        echo "Scut has been updated to v$LATEST_VERSION. Please restart your terminal to apply the update."
    else
        echo "No updates available."
    fi
}

create_shortcut() {
    echo "alias $1=\"$2\" #scut" >> "$CONFIG_FILE"
    echo "Shortcut created! Please restart your shell for the changes to apply."
}

list_shortcuts() {
    grep '#scut' "$CONFIG_FILE" || echo "No shortcuts found."
}

favorite_shortcut() {
    echo "$1" >> "$FAVORITES_FILE"
    echo "Shortcut $1 has been added to favorites."
}

unfavorite_shortcut() {
    sed -i "/^$1$/d" "$FAVORITES_FILE"
    echo "Shortcut $1 has been removed from favorites."
}

list_favorites() {
    echo "Favorite Shortcuts:"
    cat "$FAVORITES_FILE" 2>/dev/null || echo "No favorites found."
}

remove_shortcut() {
    if [ -z "$1" ]; then
        echo "Error: No shortcut name provided."
        echo "Usage: scut remove <shortcut_name>"
        return 1
    fi

    if grep -q "alias $1=" "$CONFIG_FILE"; then
        sed -i.bak "/alias $1=/d" "$CONFIG_FILE"
        echo "Shortcut $1 removed!"
        echo "Also, for changes to apply, please restart your shell."
    else
        echo "Error: Shortcut $1 does not exist."
    fi
}

display_manual() {
    echo "SCUT MANUAL"
    echo "-----------"
    echo "Usage: scut <action> [args]"
    echo ""
    echo "Actions:"
    echo "  create <name> <command>  - Create a new shortcut."
    echo "    Example: scut create nf 'neofetch'"
    echo "    Creates a shortcut named 'nf' that runs 'neofetch'."
    echo ""
    echo "  list                     - List all created shortcuts."
    echo "    Example: scut list"
    echo "    Lists all shortcuts created with scut."
    echo ""
    echo "  remove <name>            - Remove a shortcut."
    echo "    Example: scut remove nf"
    echo "    Removes the shortcut named 'nf'."
    echo ""
    echo "  favorite <name>          - Add a shortcut to favorites."
    echo "    Example: scut favorite nf"
    echo "    Adds the shortcut 'nf' to your favorites."
    echo ""
    echo "  unfavorite <name>        - Remove a shortcut from favorites."
    echo "    Example: scut unfavorite nf"
    echo "    Removes the shortcut 'nf' from your favorites."
    echo ""
    echo "  favorites                - List all favorite shortcuts."
    echo "    Example: scut favorites"
    echo "    Lists all shortcuts marked as favorites."
    echo ""
    echo "  help <action>            - Display help for a specific action."
    echo "    Example: scut help create"
    echo "    Displays help information about the 'create' action."
    echo ""
    echo "  man                      - Display this manual."
    echo "    Example: scut man"
    echo "    Displays this manual."
    echo ""
    echo "Note: After using 'create' or 'remove', you must reload your terminal or"
    echo "CHECK FOR UPDATES!!!!!: scut update"
    echo "re-source your bashrc/zshrc to apply the changes: source ~/.bashrc or source ~/.zshrc"
}

help_command() {
    case "$1" in
        create)
            echo "Usage: scut create <name> <command>"
            echo "Create a new shortcut. <name> is the name of the shortcut, and <command> is the command that the shortcut will execute."
            ;;
        list)
            echo "Usage: scut list"
            echo "List all created shortcuts."
            ;;
        favorite)
            echo "Usage: scut favorite <name>"
            echo "Mark the specified shortcut as a favorite."
            ;;
        unfavorite)
            echo "Usage: scut unfavorite <name>"
            echo "Remove the specified shortcut from your favorites."
            ;;
        favorites)
            echo "Usage: scut favorites"
            echo "List all your favorite shortcuts."
            ;;
        *)
            echo "Unknown command: $1"
            echo "Available commands are: create, list, favorite, unfavorite, favorites."
            ;;
    esac
}


# Handle actions
action="$1"
argument="$2"

case "$action" in
    create)
        create_shortcut "$2" "$3"
        ;;
    list)
        list_shortcuts
        ;;
    favorite)
        favorite_shortcut "$2"
        ;;
    unfavorite)
        unfavorite_shortcut "$2"
        ;;
    favorites)
        list_favorites
        ;;
    remove)
        remove_shortcut "$2"
        ;;
    update)
        check_for_updates
        ;;
    help)
        help_command "$2"
        ;;
    *)
        echo "Unknown action: $action"
        display_manual
        ;;
esac
