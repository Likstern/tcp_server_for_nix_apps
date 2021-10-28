# tcp_server_for_nix_apps
TCP-Server to start/stop Linux applications.

TCP-Server для запуска\остановки Linux-приложений.
Для взаимодействия с сервером использовать команду
echo "command  opt:--argument" | nc localhost 7777
command - run или close
app - имя приложения
argument - Опциональный аргумент приложения.
