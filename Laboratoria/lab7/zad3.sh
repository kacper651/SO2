#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 7
#
# Celem zajęć jest zapoznanie się z wyrażeniami regularnymi, wykorzystując
# przy tym narzędzia awk i grep oraz wszystkie inne, poznane na zajęciach.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
#

#
# Zadanie 3.
# Przeczytać zawartość pliku `dodatkowe/cpplint.txt` i usunąć z niego wszystkie
# znaczniki języka HTML – czyli ciągi znaków, rozpoczynające się od znaku <,
# aż do najbliższego znaku >. Jako wynik zwrócić pozostałą zawartość,
# pomijając linie puste i takie, których jedyną zawartość stanowią spacje.
#
cat dodatkowe/cpplint.txt | awk '{gsub(/<[a-z=/"[:space:]0-9:._]*>/, ""); gsub(/^\s*$/, ""); if (length($0)>0){print}}' 
# najpierw puste linie, potem spacje, potem tagi html 
# gsub(/<[^<>]*>/)
