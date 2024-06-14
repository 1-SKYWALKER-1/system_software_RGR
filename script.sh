#!/bin/bash

print_parameters() {
    echo "Параметри скрипта:"
    for param in "$@"; do
        echo "- $param"
    done
}

run_program() {
    local num_starts="$1"
    local num_params=$#
    local num_two_roots=0
    local num_one_roots=0
    local num_deny_roots=0

    #print_parameters "$@"
    
    for _ in $(seq 1 "$num_starts"); do
        case $num_params in
            1) ./bin/program ;;
            2) ./bin/program "$1" ;;
            3) ./bin/program "$1" "$2" ;;
            4) ./bin/program "$1" "$2" "$3" ;;
            *) echo "Неверное количество параметров!" && return 1 ;;
        esac
        result=$?
        #printf "%s\n" "$result"
        case $result in
            0) num_two_roots=$(($num_two_roots + 1));;
            1) num_one_roots=$(($num_one_roots + 1));;
            255) num_deny_roots=$(($num_deny_roots + 1));;
            *) echo "Хрень!" && return 1 ;;
        esac
    done
    if [ "$num_starts" -gt 1 ]; then
        printf "\n2 коренями - $num_two_roots \n"
        printf "\n1 коренем - $num_one_roots \n"
        printf "\nбез розв’язку - $num_deny_roots \n"
    fi
}

check_parameters() {
    if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]; then
        echo "\nПотрібно ввести від 1 до 3 параметрів."
        exit 1
    fi

    for param in "$@"; do
        if ! echo "$param" | grep -Eq '^-?[0-9]+(\([0-9]+\))?$'; then
            echo "\nПараметр $param не є цілим або дійсним числом."
            exit 1
        fi
    done
}

start_program() {
    printf "\nХочете продовжувати? (y/n/h/кількість повторів): "
    read -r answer
    case $answer in
        [Yy]* ) run_program 1 "$@" ;;
        [Nn]* ) printf "Дякую за гру!"; exit 0 ;;
        [Hh]* ) printf "Для продовження введіть 'y' або 'n', або введіть бажану кількість повторів як число.\n"; ;;
        [0-9]* ) run_program "$answer";;
        * ) printf "Будь ласка, введіть 'y' або 'n', або введіть число повторів."; start_program "$@" ;;
    esac
}

main() {
    check_parameters "$@"
    run_program 1 "$@"
    #print_parameters "$@"
    while true; do
        start_program "$@"
    done
}

main "$@"

exit 0
