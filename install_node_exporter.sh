#!/bin/bash
set -e

# --- Переменные ---
NODE_EXPORTER_VERSION="1.8.2"
INSTALL_DIR="/usr/local/bin"
USER_NAME="nodeusr"

# --- Создаём пользователя ---
if ! id "$USER_NAME" &>/dev/null; then
    useradd --no-create-home --shell /bin/false $USER_NAME
fi

# --- Скачиваем node_exporter ---
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

# --- Устанавливаем бинарник ---
mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter $INSTALL_DIR/
chmod +x $INSTALL_DIR/node_exporter

# --- Создаём systemd unit ---
cat <<EOF >/etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=$USER_NAME
Group=$USER_NAME
Type=simple
ExecStart=$INSTALL_DIR/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# --- Запускаем сервис ---
systemctl daemon-reload
systemctl enable --now node_exporter

# --- Проверка ---
echo "Node Exporter установлен и запущен."
echo "Проверить: systemctl status node_exporter"
echo "Метрики будут доступны на http://$(hostname -I | awk '{print $1}'):9100/metrics"
