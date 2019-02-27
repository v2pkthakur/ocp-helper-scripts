#!/bin/bash

subscription-manager register --username prthakur@redhat.com
subscription-manager attach --pool=8a85f99b65c8c8f1016651638fe56010
subscription-manager repos --disable='*'
subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-optional-rpms --enable=rhel-7-server-ose-3.11-rpms --enable=rhel-7-server-rh-common-rpms
