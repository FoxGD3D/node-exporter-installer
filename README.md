# Node Exporter Installer

Скрипт для автоматической установки и настройки [Prometheus Node Exporter](https://github.com/prometheus/node_exporter) на Debian/Ubuntu серверах и LXC контейнерах.

## Возможности
- Автоматическая загрузка последней версии Node Exporter
- Создание отдельного системного пользователя
- Установка бинарника в `/usr/local/bin/`
- Настройка `systemd` сервиса
- Автозапуск при старте системы

## Установка

Клонируйте репозиторий и запустите скрипт:

```bash
git clone https://github.com/FoxGD3D/node-exporter-installer.git
cd node-exporter-installer
chmod +x install_node_exporter.sh
sudo ./install_node_exporter.sh
