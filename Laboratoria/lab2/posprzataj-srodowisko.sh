#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 2
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
rm -rf 'dane/' 'so2-lab2-rozwiazania.tgz'
