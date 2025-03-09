#!/bin/bash

# Definicja kompatybilnych wersji
declare -A compatibility

# Przykładowe dane: HailoRT v4.20
compatibility["4.20"]="2024-07 v3.25.0 v2.14 v3.31.0 v1.5.0"

# Przykładowe dane: HailoRT v4.19
compatibility["4.19"]="2024-06 v3.24.0 v2.13 v3.30.0 v1.4.0"

# Funkcja wyświetlająca dostępne wersje HailoRT
function show_hailort_versions {
    echo "Dostępne wersje HailoRT:"
    for version in "${!compatibility[@]}"; do
        echo "- $version"
    done
}

# Funkcja pobierająca kompatybilne wersje dla wybranej wersji HailoRT
function get_compatible_versions {
    local hailort_version=$1
    if [[ -n "${compatibility[$hailort_version]}" ]]; then
        echo "${compatibility[$hailort_version]}"
    else
        echo "Brak danych o kompatybilności dla wersji HailoRT: $hailort_version"
        exit 1
    fi
}

# Główna część skryptu
echo "Wybierz wersję HailoRT:"
show_hailort_versions
read -p "Podaj wersję HailoRT: " selected_hailort_version

compatible_versions=$(get_compatible_versions "$selected_hailort_version")
if [[ $? -ne 0 ]]; then
    exit 1
fi

read -r ai_sw_suite dataflow_compiler model_zoo tappas integration_tools <<< "$compatible_versions"

echo "Wybrana wersja HailoRT: $selected_hailort_version"
echo "Kompatybilne wersje:"
echo "- AI SW Suite: $ai_sw_suite"
echo "- Dataflow Compiler: $dataflow_compiler"
echo "- Model Zoo: $model_zoo"
echo "- TAPPAS: $tappas"
echo "- Integration Tools: $integration_tools"

# Przykład instalacji wybranych komponentów
# Poniżej należy dodać komendy instalujące poszczególne komponenty w zależności od systemu i dostępnych źródeł
# Np.:
# install_hailort "$selected_hailort_version"
# install_ai_sw_suite "$ai_sw_suite"
# install_dataflow_compiler "$dataflow_compiler"
# install_model_zoo "$model_zoo"
# install_tappas "$tappas"
# install_integration_tools "$integration_tools"