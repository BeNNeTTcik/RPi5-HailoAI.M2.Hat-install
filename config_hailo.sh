#!/bin/bash

declare -A compatibility
compatibility["4.20.0"]="3.30.0 4.20.0 1.20.0 2.14 3.31.0"
compatibility["4.19.0"]="3.29.0 4.19.0 1.19.0 2.13 3.30.0"
compatibility["4.18.0"]="3.28.0 4.18.0 1.18.0 2.12 3.29.1"
compatibility["4.17.0"]="3.27.0 4.17.0 1.17.0 2.11 3.28.2"

function show_hailort_versions {
    echo "HailoRT versions avaliable:"
    for version in "${!compatibility[@]}"; do
        echo "- $version"
    done
}

function get_compatible_versions {
    local hailort_version=$1
    if [[ -n "${compatibility[$hailort_version]}" ]]; then
        echo "${compatibility[$hailort_version]}"
    else
        echo "No information about this version: ${hailort_version} check HailoAI website"
        exit 1
    fi
}

function ask_continue {
    while true; do
        echo "Next script is a firmware and PCIe installation."
        read -r -p "Do you want to continue? (y/n)" answer
        answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$answer" == "y" ]]; then
            echo "Continuing with the next script ..."
            ./firmware_and_PCIe.sh
            break
        elif [[ "$answer" == "n" ]]; then
            echo "Exiting script."
            exit 0
        else
            echo "Invalid input. Please enter 'y' or 'n'."
        fi
    done
}


#Main
sudo chmod +x ./firmware_and_PCIe.sh
sudo chmod +x ./hailort_install.sh
sudo chmod +x ./TAPPAS_install.sh
sudo chmod +x ./test_after_drivers.sh
sudo chmod +x ./model_zoo_install.sh 
sudo chmod +x ./dataflow_install.sh
sudo chmod +x ./example_install.sh
echo "Choose HailoRT version:"
show_hailort_versions
read -p "Write HailoRT version that will be installed: " selected_hailort_version

compatible_versions=$(get_compatible_versions "$selected_hailort_version")
if [[ $? -ne 0 ]]; then
    exit 1
fi

read -r dataflow_compiler hailort integration_tools model_zoo tappas <<< "$compatible_versions"

echo "Compatible versions:"
echo "- Dataflow Compiler: $dataflow_compiler"
echo "- HailoRT: $hailort"
echo "- Integration Tools: $integration_tools"
echo "- Model Zoo: $model_zoo"
echo "- TAPPAS: $tappas"

cat <<EOF > version.txt
dataflow_compiler="$dataflow_compiler"
hailort="$hailort"
integration_tools="$integration_tools"
model_zoo="$model_zoo"
tappas="$tappas"
EOF

ask_continue
