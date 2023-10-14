
#!/bin/bash

CURRENT_VERSION="1.0.3"


# Constants
BASHRC_FILE="$HOME/.bashrc"
FAVORITES_FILE="$HOME/.scut_favorites"
GITHUB_RAW_BASEURL="https://raw.githubusercontent.com/networph/scut/main"

# Ensure the favorites file exists
touch "$FAVORITES_FILE"

check_for_updates() {
    BASE_URL="https://raw.githubusercontent.com/networph/scut/main/version"
    LATEST_VERSION=$(curl -s -H 'Cache-Control: no-cache' "$BASE_URL" | tr -d 'v' | tr -d ' ')  # Remove "v" and spaces
    
    # Debugging: log the versions being compared
    echo "DEBUG: Current version: $CURRENT_VERSION, Latest version: $LATEST_VERSION"

    # Comparison to see if the current version is less than the latest version
    if [[ $(echo -e "$CURRENT_VERSION\n$LATEST_VERSION" | sort -V | head -n1) != "$LATEST_VERSION" && "$CURRENT_VERSION" != "$LATEST_VERSION" ]]; then
        echo "A new version of scut is available (v$LATEST_VERSION)."
        echo "Visit https://github.com/networph/scut to download the update."
    else
        echo "No updates available."
    fi
}


create_shortcut() {
    echo "alias $1=\"$2\" #scut" >> "$BASHRC_FILE"
    echo "Shortcut created! Please restart all terminals for the changes to apply."
}

list_shortcuts() {
    grep '#scut' "$BASHRC_FILE" || echo "No shortcuts found."
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
    # Check if the shortcut name is provided
    if [ -z "$1" ]; then
        echo "Error: No shortcut name provided."
        echo "Usage: scut remove <shortcut_name>"
        return 1
    fi

    # Check if the shortcut exists
    if grep -q "alias $1=" ~/.bashrc; then
        # Use sed to find and remove the line with the shortcut alias
        sed -i.bak "/alias $1=/d" ~/.bashrc
        echo "Shortcut $1 removed!"
        echo "Also, for changes to apply. Please restart terminals."
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
    echo "re-source your bashrc to apply the changes: source ~/.bashrc"
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
        display_manual  # display manual if the action is not recognized
        ;;
esac
