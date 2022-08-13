# -*- mode: ruby -*-
# vi: set ft=ruby :

# Copyright 2022 Dael Saint-Surin aka dvoltaire

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

NODE_NAME = 'k8s'
IP_PREFIX = '192.168.56.'  
IP_SUFFIX = 10
NODE_COUNT = 1
OS_BASE_NAME = "ubuntu/focal64"
OS_BASE_VERSION = "20220804.0.0"
VM_MEMORY = 2048
VM_CPU = 1

Vagrant.configure(2) do |config|
  config.vm.provision "shell", path: "bootstrap.sh"
  (1..NODE_COUNT).each do |count|
      current_node = sprintf("%02d", count-1)
      config.vm.define "#{NODE_NAME}-#{current_node}" do |node|
        node.vm.box               = OS_BASE_NAME
        node.vm.box_check_update  = false
        node.vm.box_version       = OS_BASE_VERSION
        node.vm.hostname          = "#{NODE_NAME}-#{current_node}.example.com"
        node.vm.network "private_network", ip: "#{IP_PREFIX}#{IP_SUFFIX+count-1}"
        node.vm.synced_folder "./", "/playground"
        node.vm.provider :virtualbox do |v|
          v.name    = "#{NODE_NAME}-#{current_node}"
          v.memory  = VM_MEMORY
          v.cpus    = VM_CPU
        end
      end
  end
end
