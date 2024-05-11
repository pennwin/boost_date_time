#!/bin/bash

sudo apt update -y
sudo apt install net-tools jq -y
wget https://github.com/airchains-network/junction/releases/download/v0.1.0/junctiond
chmod +x junctiond
sudo mv junctiond /usr/local/bin
junctiond init $1
wget https://github.com/airchains-network/junction/releases/download/v0.1.0/genesis.json
cp -fr genesis.json ~/.junction/config/genesis.json
sed -i 's/^.*persistent_peers = ""$/persistent_peers = "48887cbb310bb854d7f9da8d5687cbfca02b9968@35.200.245.190:26656,2d1ea4833843cc1433e3c44e69e297f357d2d8bd@5.78.118.106:26656,de2e7251667dee5de5eed98e54a58749fadd23d8@34.22.237.85:26656,1918bd71bc764c71456d10483f754884223959a5@35.240.206.208:26656,ddd9aade8e12d72cc874263c8b854e579903d21c@178.18.240.65:26656,eb62523dfa0f9bd66a9b0c281382702c185ce1ee@38.242.145.138:26656,0305205b9c2c76557381ed71ac23244558a51099@162.55.65.162:26656,086d19f4d7542666c8b0cac703f78d4a8d4ec528@135.148.232.105:26656,3e5f3247d41d2c3ceeef0987f836e9b29068a3e9@168.119.31.198:56256,8b72b2f2e027f8a736e36b2350f6897a5e9bfeaa@131.153.232.69:26656,6a2f6a5cd2050f72704d6a9c8917a5bf0ed63b53@93.115.25.41:26656,e09fa8cc6b06b99d07560b6c33443023e6a3b9c6@65.21.131.187:26656"/' ~/.junction/config/config.toml
sed -i 's/^.*minimum-gas-prices =.*/minimum-gas-prices = "0.00025amf"/' ~/.junction/config/app.toml

cat > aird.service <<EOF
[Unit]
Description=AirChain Node
After=network.target

[Service]
User=ubuntu
Type=simple
ExecStart=/usr/local/bin/junctiond start --home $HOME/.junction
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo mv aird.service /etc/systemd/system/
sudo systemctl daemon-reload

sudo systemctl start aird.service
