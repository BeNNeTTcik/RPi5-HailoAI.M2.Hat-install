#!/bin/bash
function ask_continue {
    while true; do
        echo "Next script is a HailoRT installation."
        read -r -p "Do you want to continue? (y/n)" answer
        answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$answer" == "y" ]]; then
            echo "Continuing with the next script ..."
            ./hailort_install.sh
            break
        elif [[ "$answer" == "n" ]]; then
            echo "Exiting script."
            exit 0
        else
            echo "Invalid input. Please enter 'y' or 'n'."
        fi
    done
}

if(ls /dev/hailo*); then
    echo "Hailo device is detected under /dev folder"
    ls /dev/hailo*
else
    echo "Hailo device is not detected, something went wrong"
fi

ask_continue
