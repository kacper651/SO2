#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 7
#
# Skrypt usuwa wszystkie pliki środowiska roboczego oraz ewentualne archiwa,
# pozostawiając jedynie oryginalne skrypty pomocnicze i rozwiązania zadań.
#
set -o errexit
set -o nounset
set -o pipefail


#
# Czyszczenie
#
rm -rf 'dodatkowe/' 'dodatkowe.tar.xz' 'so2-lab7-rozwiazania.tgz'
