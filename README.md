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

Use this to avoid Burnout Syndrome when deploying your Docker wrapped application to nginx.

## Table of content

* [Default Variables](#default-variables)
  * [client_max_body_size](#client_max_body_size)
  * [env](#env)
  * [image_local](#image_local)
  * [image_name](#image_name)
  * [network_name](#network_name)
  * [project_port](#project_port)
* [Dependencies](#dependencies)
* [License](#license)
* [Author](#author)

---

## Default Variables

### client_max_body_size

Maximum file upload size for Nginx. Value as defined by [nginx documentation](http://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size)

#### Default value

```YAML
client_max_body_size: 1M
```

### env

Dictionary of environment variables that will be passed to the docker container.

#### Default value

```YAML
env:
  nginx_docker: yes
```

#### Example usage

```YAML
env:
  PORT: 80
  SECRET_TOKEN: xa2z3ik6
```

### image_local

Path to the extracted docker image. When empty, the role will attempt to build the image on local host before uploading the image to the remote. Expects the Dockerfile to be present in the same directory as the playbook.

#### Default value

```YAML
image_local: ''
```

#### Example usage

```YAML
image: './dist/my-app.tar'
```

### image_name

Name of image that will be pulled from the docker repository.

#### Default value

```YAML
image_name: ''
```

#### Example usage

```YAML
image: 'requarks/wiki'
```

### network_name

Name of docker network used by this container. The role will create it if necessary

#### Default value

```YAML
network_name: practical-ansible
```

#### Example usage

```YAML
network_name: 'totally-separated-network'
```

### project_port

Inner port number of the container. The role will map this port from docker to nginx proxy|

#### Default value

```YAML
project_port: 80
```

#### Example usage

```YAML
project_port: 3000
```

## Dependencies

* {'role': 'practical-ansible.nginx_project'}

## License

MIT

## Author

Pavel Žák
