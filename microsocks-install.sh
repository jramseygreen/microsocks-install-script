#! /bin/bash

# check dependencies
echo "checking dependencies..."
if ! command -v gcc &> /dev/null
then
    echo "gcc could not be found."
    sudo apt-get install gcc -y
fi
if ! command -v unzip &> /dev/null
then
    echo "unzip could not be found."
    sudo apt-get install unzip -y
fi
if ! command -v wget &> /dev/null
then
    echo "wget could not be found."
    sudo apt-get install wget -y
fi

# if service doesn't exist make initial install
if ! test -f "/etc/systemd/system/microsocks.service"; then
    echo "This will download and compile microsocks, and create a systemd service for running it."
    wget "https://github.com/rofl0r/microsocks/archive/refs/heads/master.zip"
    unzip -q master.zip
    rm master.zip
    cd microsocks-master
    gcc *.c -o microsocks -pthread
    mkdir /opt/microsocks
    mv microsocks "/opt/microsocks/"
    cd ../
    rm -r microsocks-master
fi

# get port, user and password
echo ""
echo "configure microsocks"
read -p "Enter port: " port
read -p "Enter username: " username
read -s -p "Enter password: " password

echo "[Unit]" > /etc/systemd/system/microsocks.service
echo "Description=microsocks socks5 proxy service" >> /etc/systemd/system/microsocks.service
echo "After=network-online.target" >> /etc/systemd/system/microsocks.service
echo "" >> /etc/systemd/system/microsocks.service
echo "[Service]" >> /etc/systemd/system/microsocks.service
echo "ExecStart=/opt/microsocks/microsocks -p "$port" -u "$username" -P "$password"" >> /etc/systemd/system/microsocks.service
echo "" >> /etc/systemd/system/microsocks.service
echo "[Install]" >> /etc/systemd/system/microsocks.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/microsocks.service

systemctl daemon-reload
systemctl enable microsocks
systemctl start microsocks
echo ""
systemctl status microsocks
echo "control the service with 'systemctl <action> microsocks'."
