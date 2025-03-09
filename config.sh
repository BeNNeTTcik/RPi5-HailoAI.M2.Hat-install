#!/bin/bash
#fetch the latest version of the firmware
version=$(curl -s https://api.github.com/repos/hailo-ai/hailort-drivers/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
echo "The latest version of the firmware is $version"


# URL strony z tabelą kompatybilności
URL="https://hailo.ai/developer-zone/documentation/hailo-sw-suite-2025-01/?page=suite%2Fversions_compatibility.html#id1"

# Pobranie zawartości strony
page_content=$(curl -s "$URL")

# Wyodrębnienie tabeli kompatybilności
compatibility_table=$(echo "$page_content" | sed -n '/<table/,/<\/table>/p')

# Sprawdzenie, czy tabela została znaleziona
if [[ -z "$compatibility_table" ]]; then
    echo "Nie udało się znaleźć tabeli kompatybilności na stronie."
    exit 1
fi

# Wyodrębnienie nagłówków tabeli
headers=$(echo "$compatibility_table" | grep -oP '(?<=<th>).*?(?=</th>)')

# Wyodrębnienie wierszy tabeli
rows=$(echo "$compatibility_table" | grep -oP '(?<=<tr>).*?(?=</tr>)')

# Wyświetlenie nagłówków
echo "Tabela kompatybilności wersji:"
echo "$headers" | awk '{printf "| %-20s ", $0} END {print "|"}'

# Wyświetlenie separatora
echo "$headers" | awk '{printf "|----------------------"} END {print "|"}'

# Wyświetlenie wierszy tabeli
echo "$rows" | while read -r row; do
    columns=$(echo "$row" | grep -oP '(?<=<td>).*?(?=</td>)')
    echo "$columns" | awk '{printf "| %-20s ", $0} END {print "|"}'
done