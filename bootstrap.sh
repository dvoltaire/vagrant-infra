#!/bin/bash

# Copyright 2022 Dael Saint-Surin aka dvoltaire

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo '----------------------------'
echo '--- Run Bootstrap Script ---'
BIN='/usr/local/bin'
DEBIAN_FRONTEND=noninteractive

# Install Packages a few packages
echo '--- Install Utilies & Git ---'
add-apt-repository ppa:git-core/ppa &>/dev/null
apt-get update &>/dev/null && apt-get install -y \
  neovim vim \
  tree jq net-tools \
  curl wget lynx \
  zsh git build-essential \
  sipcalc \
  haproxy \
  snap &>/dev/null

snap install yq --channel=v3/stable

echo '--- Instal Kind ---'
curl -fsSLo ./kind "https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64"
chmod +x ./kind
[ -f ./kind ] && mv ./kind $BIN

# Install K3D
echo '--- Install K3D ---'
curl -fsSL "https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh" | bash &>/dev/null
[ -f ./k3d ] && mv ./k3d $BIN

# Install kubectl
echo '--- Install kubectl ---'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &>/dev/null
chmod +x ./kubectl
[ -f ./kubectl ] && mv ./kubectl $BIN

# Install Kustomize
echo '--- Install kustomize ---'
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash &>/dev/null
[ -f ./kustomize ] && mv ./kustomize $BIN

# Install HELM
echo '--- Install HELM ---'
curl -fsSL "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3" | bash &>/dev/null

# Install Docker
echo '--- Install Docker ---'
curl -fsSL "https://get.docker.com" | bash &>/dev/null
gpasswd -a vagrant docker

# Install oh-my-zsh
usermod -s /bin/zsh vagrant
echo '--- Install oh-my-zsh ---'

su -l vagrant -c '
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

egrep -q "zsh-syntax-highlighting|zsh-autosuggestions" ~/.zshrc

if [ $? -ne 0 ]; then
  sed -i "s!plugins=(git)!plugins=(git zsh-syntax-highlighting zsh-autosuggestions)!" ~/.zshrc
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

NEW_THEME="ZSH_THEME=\"powerlevel10k/powerlevel10k\""
OLD_THEME=`grep ^ZSH_THEME ~/.zshrc`

if [[ "$OLD_THEME" != "$NEW_THEME" ]]; then
  sed -i "s!$OLD_THEME!$NEW_THEME!" ~/.zshrc
fi
'
echo '--- Bootstrap Script Complet ---'
# END Of SCRIPT
