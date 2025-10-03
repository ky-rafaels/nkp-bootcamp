#!/bin/bash

set -e

echo 'PATH=$PATH:/usr/local/bin' >> ~/.bashrc
echo 'alias k="kubectl"' >> ~/.bashrc
source ~/.bashrc

echo "Installing common tools on jump host"
# Install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Install k9s 
sudo dnf install https://github.com/derailed/k9s/releases/download/v0.50.13/k9s_linux_amd64.rpm -y

echo "installing kns and ktx"
wget https://github.com/junegunn/fzf/releases/download/v0.65.2/fzf-0.65.2-linux_amd64.tar.gz
tar -xzvf fzf-0.65.2-linux_amd64.tar.gz
mv fzf /usr/local/bin/fzf
rm fzf-0.65.2-linux_amd64.tar.gz
curl https://raw.githubusercontent.com/blendle/kns/master/bin/kns -o /usr/local/bin/kns && chmod +x $_
curl https://raw.githubusercontent.com/blendle/kns/master/bin/ktx -o /usr/local/bin/ktx && chmod +x $_

# # Install kind k8s for bootstrap
# [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.30.0/kind-linux-amd64
# chmod a+x ./kind
# mv ./kind /usr/local/bin/kind

# Uncomment for installing go task tool
# curl -1sLf 'https://dl.cloudsmith.io/public/task/task/setup.rpm.sh' | sudo -E bash
# sudo dnf install task -y

echo "DONE!"