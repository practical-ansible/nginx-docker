#!/usr/bin/env bash

docker stop hosting-test 2> /dev/null
docker rm hosting-test 2> /dev/null
docker build -t hosting-test .
docker run -v /var/run/docker.sock:/var/run/docker.sock -d -P --rm --name hosting-test hosting-test

PORT=$(docker port hosting-test 22 | cut -d ':' -f2)

echo -e "[test]\nroot@127.0.0.1 ansible_port=${PORT} ansible_password=test" > inventory

# Make role accessible
mkdir roles 2> /dev/null
ln -s ../.. roles/practical-ansible.nginx-docker 2> /dev/null 

# Build and export the image from docker
docker build -t info-test:0.1.0 test
docker save info-test > test_app.tar

# Image must be removed, so we can test that it was added
docker image rm info-test:0.1.0

export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook test-deploy.yml -i inventory -vvv

docker rm hosting-test info-test
