#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 7
#
# Skrypt tworzy środowisko robocze ze wszystkimi niezbędnymi plikami
# na potrzeby realizacji zadań z danego tematu zajęć laboratoryjnych.
#
# Uwaga! Istniejące pliki i katalogi środowiska zostaną usunięte!
#
# Analiza niniejszego pliku nie jest konieczna, a nawet jest niewskazana.
# Proszę oszczędzić sobie życia i skupić się wyłącznie na rozwiązaniach :-)
#
set -o errexit
set -o nounset
set -o pipefail

URL='https://datko.pl/SO2/dodatkowe.tar.xz'
FILE=$(basename "${URL}")
DIR="${FILE%.tar.xz}"
TOOL=()  # auto-selected in script


#
# Select tool for download
#
echo -n 'Looking for a download tool... '
if [ "${#TOOL[@]}" -eq 0 ] && ( command -v 'wget' &> /dev/null ); then
    TOOL=('wget')
fi
if [ "${#TOOL[@]}" -eq 0 ] && ( command -v 'curl' &> /dev/null ); then
    TOOL=('curl' '-LJO')
fi
if [ "${#TOOL[@]}" -eq 0 ]; then
    echo 'ERROR'
    echo 'Could not find wget or curl.'
    echo 'Please install one of these before proceeding.'
    exit 2
else
    echo 'DONE'
fi


#
# Fetch sources archive
#
echo -n 'Downloading the sources... '
if [ ! -f "${FILE}" ]; then
    echo ''  # just add new line to previous echo
    "${TOOL[@]}" "${URL}"
else
    echo 'SKIPPED'
fi


#
# Remove existing sources
#
echo -n 'Removing any existing sources... '
if [ -d "${DIR}" ]; then
    rm -rf "${DIR}"
fi
echo 'DONE'


#
# Extract the archive
#
echo -n 'Extracting the sources... '
umask 022
tar -xf "${FILE}"
echo 'DONE'
