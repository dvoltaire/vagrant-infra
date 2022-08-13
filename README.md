# vagrant-infra

This Vagrantfile along with the bootstrap scripts have everything to run a local multi-node kubernetes on docker.

### Tools That will be installed on the VM
- docker
- k3d
- kind
- kubectl
- kustomize
- helm
- git
- vim / neovim
- curl / get / lynx
- etc...

### Running Vagrant
You need both [vagrant](https://www.vagrantup.com/docs/installation) and [Virtual box](https://www.virtualbox.org/wiki/Downloads) installed on your system.

### Launch the VM
```shell=
vagrant up
```

### SSH to the VM
```shell=
vagrant ssh
```

### Run A kubernetes Cluster
```shell=
cd /playground/src/
k3d cluster create --config k3d-k8s.yaml
```

### Verify the cluster is created
```shell=
kubectl cluster-info

kubectl get nodes
```

### Enjoy ~ Happy Coding!