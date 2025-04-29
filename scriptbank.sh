#!/bin/bash

DB="bank.csv"

touch "$DB"
if [[ ! -s "$DB" ]]; then
    echo "Client,Sold curent" > "$DB"
fi

menu() {
    echo -e "\n=== Aplicatie Bancara ==="
    echo "1) Creare client"
    echo "2) Modificare sold"
    echo "3) Stergere client"
    echo "4) Lista clienti"
    echo "Orice alta tasta: Iesire"
    echo -n "Alegeti o optiune: "
}

add_client() {
    read -p "Introduceti numele clientului: " name
    if grep -q "^$name," "$DB"; then
        echo "Clientul cu numele '$name' exista deja."
    else
        echo "$name,0" >> "$DB"
        echo "Clientul '$name' a fost adaugat cu succes."
    fi
}

modify_sold() {
    read -p "Introduceti numele clientului: " name
    if grep -q "^$name," "$DB"; then
        read -p "Introduceti noul sold: " sold
        sed -i "/^$name,/c\\$name,$sold" "$DB"
        echo "Soldul clientului '$name' a fost actualizat la $sold."
    else
        echo "Clientul cu numele '$name' nu exista."
    fi
}

delete_client() {
    read -p "Introduceti numele clientului: " name
    if grep -q "^$name," "$DB"; then
        sed -i "/^$name,/d" "$DB"
        echo "Clientul '$name' a fost sters."
    else
        echo "Clientul cu numele '$name' nu exista."
    fi
}

list_clients() {
    echo -e "\n=== Lista clienti ==="
    column -t -s, "$DB"
}

while true; do
    menu
    read opt
    case $opt in
        1) add_client ;;
        2) modify_sold ;;
        3) delete_client ;;
        4) list_clients ;;
        *) break ;;
    esac
done
