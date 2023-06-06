#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 6
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
rm -rf 'coreutils-8.32/' 'coreutils-8.32.tar.xz' 'dodatkowe/' 'dodatkowe.tar.xz' 'so2-lab6-rozwiazania.tgz'
