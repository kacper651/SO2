#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 3
#
# Celem zajęć jest pogłębienie wiedzy na temat struktury systemu plików,
# poruszania się po katalogach i kontroli uprawnień w skryptach powłoki.
# Proszę unikać wykorzystywania narzędzia `find` w ramach bieżących zajęć.
#
# Nie przywiązujemy wagi do środowiska roboczego – zakładamy, że jego pliki,
# inne niż te podane wprost w treści zadań, mogą ulec zmianie, a przygotowane
# rozwiązania nadal powinny działać poprawnie (robić to, o czym zadanie mówi).
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 4.
# Odnaleźć wszystkie dowiązania miękkie w katalogu `dane/pierwiastki/`, które
# *poprawnie* wskazują na jakieś miejsce w systemie plików (ich cel istnieje).
# Wyświetlić ścieżki kanoniczne do wskazywanych miejsc, każdą w osobnej linii.
#
for file in dane/pierwiastki/*; do
    if [ -h "$file" ] && [ -e "$file" ]; then
        echo $(readlink -f "$file")
    fi
done
