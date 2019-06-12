#!/bin/sh

# パッケージ一覧の更新
apt-get -y update

# HTTPS経由でリポジトリを利用できるようパッケージをインストール
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# GPG鍵の追加
# 暗号化されたdockerパッケージの複号に利用
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# リポジトリの登録
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# パッケージ一覧の更新
apt-get -y update

# dockerのインストール
apt-get -y install docker-ce docker-ce-cli containerd.io

# docker-composeのインストール
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chown vagrant:docker /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# dockerグループを設定してvagrantユーザーをdockerグループへ追加
groupadd docker
usermod -aG docker vagrant

# 設定反映のための再起動
reboot