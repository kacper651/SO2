#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 4
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
rm -rf 'linux-5.11.13/' 'linux-5.11.13.tar.xz' 'so2-lab4-rozwiazania.tgz'
