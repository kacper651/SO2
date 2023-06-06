#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 6
#
# Skrypt weryfikuje działanie rozwiązań do zadań – sprawdzany jest
# wynik działania skryptów w porównaniu z wartością oczekiwaną.
#
# Uwaga! Plik ma charakter pomocniczy, ostateczna ocena należy do prowadzącego!
#
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

DETAILS=''

verify() {
    FILE="$1"
    EXPECTED="$2"
    ACTUAL=$(bash -o errexit -o nounset "${FILE}" | LC_ALL=C sort)

    echo -n "${FILE} -> "
    if [ "${ACTUAL}" = "${EXPECTED}" ]; then
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}KO${NC}"

        DETAILS+="\n=======> ${FILE} <======="
        DETAILS+="\nExpected:\n"'```'"\n${EXPECTED}\n"'```'"\n"
        DETAILS+="\nGot:\n"'```'"\n${ACTUAL}\n"'```'"\n"
    fi
}

verify_unsorted() {
    FILE="$1"
    EXPECTED="$2"
    ACTUAL=$(bash -o errexit -o nounset "${FILE}")

    echo -n "${FILE} -> "
    if [ "${ACTUAL}" = "${EXPECTED}" ]; then
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}KO${NC}"

        DETAILS+="\n=======> ${FILE} <======="
        DETAILS+="\nExpected:\n"'```'"\n${EXPECTED}\n"'```'"\n"
        DETAILS+="\nGot:\n"'```'"\n${ACTUAL}\n"'```'"\n"
    fi
}


#
# Zadanie 1
#
read -r -d '' EXPECTED << EOF
Ile cię trzeba cenić, ten tylko się dowie,
Panno święta, co Jasnej bronisz Częstochowy
Jak mnie dziecko do zdrowia powróciłaś cudem
I zaraz mogłem pieszo, do Twych świątyń progu
Tymczasem przenoś moją duszę utęsknioną
Do tych pól malowanych zbożem rozmaitem,
Gdzie panieńskim rumieńcem dzięcielina pała,
EOF

verify_unsorted 'zad1.sh' "${EXPECTED}"


#
# Zadanie 2
#
read -r -d '' EXPECTED << EOF
user1
user2
EOF

verify 'zad2.sh' "${EXPECTED}"


#
# Zadanie 3
#
read -r -d '' EXPECTED << EOF
117
119
55
8
97
EOF

verify 'zad3.sh' "${EXPECTED}"


#
# Zadanie 4
#
read -r -d '' EXPECTED << EOF
CPU: 99.9
RAM: 91.4
EOF

verify 'zad4.sh' "${EXPECTED}"


#
# Zadanie 5
#
read -r -d '' EXPECTED << EOF
4422
539
63
EOF

verify 'zad5.sh' "${EXPECTED}"


#
# Zadanie 6
#
# NOTE(sdatko): For some reason, the coreutils-8.32/lib/ directory can have
#               either 28672 Bytes on one system and 24576 Bytes on the other.
#               I have no idea why, as far as I checked there was the same
#               filesystem (ext4) used, as well as the SHA sum of all files
#               was identical. Hence, there is this calculation introduced.
#
EXPECTED=$(if ( command -v 'gdu' &> /dev/null ); then
               TOOL='gdu'
           else
               TOOL='du'
           fi
           ("${TOOL}" --summarize --bytes --apparent-size coreutils-8.32/ 2>/dev/null \
            || echo '51036001') \
                | awk '{ i=1; print $i /(i+1)/(i+1)/(i+1)/(i+1)/(i+1) \
                                       /(i+1)/(i+1)/(i+1)/(i+1)/(i+1) \
                                       /(i+1)/(i+1)/(i+1)/(i+1)/(i+1) \
                                       /(i+1)/(i+1)/(i+1)/(i+1)/(i+1) }')

verify 'zad6.sh' "${EXPECTED}"


#
# Zadanie 7
#
read -r -d '' EXPECTED << EOF
087-65-4321 40
087-75-4321 32.8333
123-12-1234 71.1667
123-45-6789 68.5
143-12-1234 72.6667
223-45-6789 67.6667
234-56-2890 66.8333
234-56-7890 66
345-67-3901 9.83333
345-67-8901 24.1667
456-71-9012 61
456-78-9012 62.6667
565-89-0123 44.1667
567-89-0123 51.5
632-79-9439 26.8333
632-79-9939 39.3333
EOF

verify 'zad7.sh' "${EXPECTED}"


#
# Zadanie 8
#
read -r -d '' EXPECTED << EOF
Lorem ipsum dolor sit amet elit viverra et, tristique bibendum, tellus. Nunc
ultricies porta. Sed lobortis laoreet fermentum. Vivamus a dolor accumsan at,
suscipit quis, luctus et fringilla et, scelerisque ligula, elementum odio id
lectus. Nam feugiat quam placerat fringilla, massa. Pellentesque habitant morbi
tristique in, suscipit vitae, nunc. Phasellus facilisis eget, accumsan
interdum. Nulla semper. Morbi sem dolor sit amet dolor. Praesent lacinia neque.
Pellentesque tincidunt wisi, eu fermentum consectetuer. Aenean ipsum primis in
dictum lectus est eu sem at tortor. In tincidunt, tortor pede rhoncus nunc. Sed
fringilla ipsum vitae leo. Donec elementum fringilla faucibus, erat felis,
ullamcorper ultrices nec, dictum eget, sagittis vel, quam. Sed pharetra. Donec
tortor. Morbi porttitor, quam porta tincidunt. Nullam justo consequat sed,
ullamcorper feugiat, urna augue, id nonummy eget, sagittis malesuada. Donec
mauris sit amet, nonummy commodo vehicula, dui vel quam. Nullam eleifend
lacinia, risus suscipit erat. Aliquam rhoncus eget, eros. Maecenas mi metus,
ullamcorper at, quam. Mauris vel felis non felis. Phasellus ac orci consequat
tortor. Suspendisse in elit. Mauris pellentesque, wisi. Vestibulum scelerisque.
Proin lacus. Aenean faucibus orci blandit egestas.
EOF

verify_unsorted 'zad8.sh' "${EXPECTED}"


#
# Zadanie 9
#
read -r -d '' EXPECTED << EOF
1 48
10 27
11 33
12 33
13 13
14 11
15 8
16 8
2 32
27 1
3 27
4 39
5 37
6 65
7 58
8 47
9 52
EOF

verify 'zad9.sh' "${EXPECTED}"


#
# Zadanie 10
#
read -r -d '' EXPECTED << 'EOF'
12  Jarosław Rudy
162  Cariusz Daban
2  Paweł Lampe`````````
2222  Szymon Datko 
242  Doktor Jarosław Rudy
368  Paweł Lampe
458  Dariusz Caban
4862  Kamil Szyc
8480  Szymon Datko
917  Mariusz Uchroński
EOF

verify 'zadA.sh' "${EXPECTED}"


#
# Display details about the failures
#
if [ -n "${DETAILS}" ]; then
    if [ "$1" = '--verbose' ]; then
        echo -e "${DETAILS}"
    else
        echo -e "\nRun \`$0 --verbose\` to display details about the errors."
    fi
fi
