# Nginx-docker for ansible

[![Integration](https://github.com/practical-ansible/nginx-docker/workflows/CI/badge.svg)](https://github.com/practical-ansible/nginx-docker/actions)
[![Quality](https://img.shields.io/ansible/quality/48591.svg)](https://galaxy.ansible.com/practical-ansible/nginx_docker)
[![Downloads](https://img.shields.io/ansible/role/d/48591.svg)](https://galaxy.ansible.com/practical-ansible/nginx_docker)
[![Role](https://img.shields.io/ansible/role/48591)](https://galaxy.ansible.com/practical-ansible/nginx_docker)

Use Ansible to deploy Docker projects to Nginx with or without https. This role does not really care what language you used to create your app. Created to be used with continuous integration and continuous deployment tools.

## Features

* Builds or uses prebuilt docker image
* Does not require docker registry
* Configures https via [nginx_project](https://github.com/practical-ansible/nginx-project)
* Automatically replaces old versions via project_name

## Prerequisities

* Target user with rights to config nginx
* Target user with rights to run docker

## Install

```shell
ansible-galaxy install practical-ansible.nginx_docker
```

## Example playbook

This would be the most usual playbook

```yaml
---
- name: Deploy to testing Docker container
  hosts: all
  roles:
    - role: practical-ansible.nginx_docker
      vars:
        admin_email: 'admin@test.info'
        image_local: 'test_app.tar'
        project_port: '3000'
        project_name: 'my-app'
        project_version: '0.1.0'
        server_names: 'localhost,www.localhost'
        use_ssl: true
        env:
          print_this: 'Testing deployment: X Æ A-12'
```

You can find more examples in the [__tests__](https://github.com/practical-ansible/nginx-docker/tree/master/__tests__) directory.

## Example CI

There are some more [examples of configuration](./examples).

# Reference manual
