#!/bin/bash

# Function to create a user
create_user() {
    read -p "Enter username to create: " USERNAME
    if id "$USERNAME" &>/dev/null; then
        echo "User $USERNAME already exists."
    else
        sudo useradd "$USERNAME"
        if [ $? -eq 0 ]; then
            echo "User $USERNAME created successfully."
        else
            echo "Failed to create user $USERNAME."
        fi
    fi
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " USERNAME
    if id "$USERNAME" &>/dev/null; then
        sudo userdel -r "$USERNAME"
        if [ $? -eq 0 ]; then
            echo "User $USERNAME deleted successfully."
        else
            echo "Failed to delete user $USERNAME."
        fi
    else
        echo "User $USERNAME does not exist."
    fi
}

# Function to list users
list_users() {
    echo "List of users:"
    cut -d: -f1 /etc/passwd | less
}

# Main menu
while true; do
    echo "User Management Script"
    echo "1. Create User"
    echo "2. Delete User"
    echo "3. List Users"
    echo "4. Exit"
    read -p "Choose an option [1-4]: " OPTION

    case $OPTION in
        1)
            create_user
            ;;
        2)
            delete_user
            ;;
        3)
            list_users
            ;;
        4)
            echo "Exiting the script."
            break
            ;;
        *)
            echo "Invalid option. Please choose between 1 and 4."
            ;;
    esac
done
