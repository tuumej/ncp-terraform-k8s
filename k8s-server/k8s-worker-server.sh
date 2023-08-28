#!/bin/bash

# 01. Install docker
sudo apt-get update
sudo apt-get -y install ca-certificates curl gnupg lsb-release
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# ERROR 시 (Package 'docker-ce' has no installation candidate)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker --version | docker ps
systemctl enable docker


# 02. Install k8s
swapoff -a && sed -i '/swap/s/^/#/' /etc/fstab
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

systemctl start kubelet
systemctl enable kubelet


#------------------------------------------ ERROR
#[preflight] Running pre-flight checks
#error execution phase preflight: [preflight] Some fatal errors occurred:
#        [ERROR CRI]: container runtime is not running: output: time="2023-08-22T13:56:36+09:00" level=fatal msg="validate service connection: validate CRI v1 runtime API for endpoint \"unix:///var/run/containerd/containerd.sock\": rpc error: code = Unimplemented desc = unknown service runtime.v1.RuntimeService"
#, error: exit status 1
#[preflight] If you know what you are doing, you can make a check non-fatal with `--ignore-preflight-errors=...`
#To see the stack trace of this error execute with --v=5 or higher
#------------------------------------------ ERROR
# 위 에러 해결..
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd

# 03. kubeadm init 을 실행하고 출력되는 명령어 url를 확인 후 실행할 부분
# kubeadm join 172.16.1.7:6443 --token wcc5n5.6t7e4grzlfp1k6k8 \
#        --discovery-token-ca-cert-hash sha256:b1dc1c9fdaec48c7d43e2b951d6f56d349604d17f7861c7c867d50f4636be84c


#
#mkdir -p $HOME/.kube
#vi $HOME/.kube/config # master server 의 $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config
