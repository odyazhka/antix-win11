#!/bin/bash

echo -e "\e[1;33m iwd запущен! \e[0m"
echo -e "\e[1;37m================================================================================\e[0m"
echo -e "\e[1;36m a - показать сети, d - подключиться, q - выход \e[0m"

while true; do
    read -n1 -s key  # читаем одну клавишу без Enter
    case "$key" in

        s)
            echo -e "\nСканирование..."
            sudo iwctl station wlan0 scan
            echo ""
            echo -e "\e[1;36m a - показать сети, d - подключиться, q - выход \e[0m"
            echo ""
            ;;

        a)
            sudo iwctl station wlan0 scan
            sudo iwctl station wlan0 get-networks
            echo " "
            echo -e "\e[1;36m a - показать сети, d - подключиться, q - выход \e[0m"
            echo ""
            ;;

        q)
            echo ""
            echo -e "\e[1;33m Выход..."
            sleep 2
            break
            ;;

        d)
            echo -e "\e[1;37m Cовет: выделите название сети курсором и нажмите колёсико мыши \e[0m \e[1;32m"
            echo ""
            read -p " Название сети: ${RESER}" ssid
            echo -e "\e[0m"
            sudo iwctl station wlan0 connect "$ssid"
            
            if sudo iwctl station wlan0 connect "$ssid"; then
                sudo dhcpcd "wlan0"
                echo -e "\e[1;33m Подключено к $ssid! \e[0m"
                sleep 5
                break
            else
                echo -e "\e[1;31m Не удалось подключиться к $ssid! \e[0m"
                echo -e "\e[1;37m================================================================================\e[0m"
                echo -e "\e[1;36m a - показать сети, d - подключиться, q - выход \e[0m"
                echo ""
            fi
            ;;
        *)
            echo "Неизвестная клавиша: $key"
            echo -e "\e[1;37m================================================================================\e[0m"
            echo -e "\e[1;36m a - показать сети, d - подключиться, q - выход \e[0m"
            echo ""
            ;;
    esac
done