#!/bin/bash
set -e

echo "[*] Updating system..."
apt update && apt install -y \
  git curl wget unzip build-essential \
  python3 python3-pip \
  tmux zsh \
  nmap netcat socat \
  fzf ripgrep bat jq \
  exiftool binwalk foremost steghide \
  tcpdump tshark wireshark \
  hashcat john \
  gdb libgmp-dev libmpc-dev libmpfr-dev \
  apt-transport-https ca-certificates software-properties-common gnupg lsb-release

echo "[*] Installing Python tools..."
pip3 install -U \
  pwntools pycryptodome sympy requests flask gmpy2 angr

echo "[*] Installing GEF..."
git clone https://github.com/hugsy/gef.git /opt/gef
echo "source /opt/gef/gef.py" >> ~/.gdbinit

echo "[*] Installing ROPgadget..."
wget https://github.com/JonathanSalwan/ROPgadget/archive/refs/heads/master.zip -O /tmp/rop.zip
unzip /tmp/rop.zip -d /opt/
rm /tmp/rop.zip

echo "[*] Installing RsaCtfTool..."
git clone https://github.com/Ganapati/RsaCtfTool.git /opt/RsaCtfTool

echo "[*] Installing stegseek..."
wget https://github.com/RickdeJager/stegseek/releases/latest/download/stegseek -O /usr/local/bin/stegseek
chmod +x /usr/local/bin/stegseek

echo "[*] Installing Docker and Docker Compose..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  > /etc/apt/sources.list.d/docker.list

apt update && apt install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker $USER

echo "[*] Installing docker-compose..."
curl -L "https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "[✓] All done. Reboot or re-login to activate docker group changes."
