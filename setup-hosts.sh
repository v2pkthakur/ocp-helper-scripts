#!/bin/bash
ansible-playbook -v pre-reqs.yaml --ask-vault-pass
cp tested-copy-28082018/hosts /etc/ansible/hosts
mkdir /etc/ansible/group_vars
cp tested-copy-28082018/OSEv3.yaml /etc/ansible/group_vars/

