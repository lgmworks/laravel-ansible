# Laravel-ansible

## This project can:
1. Provision the server, php, nginx, supervisor, redis, node, mysql
2. Configure nginx and php to serve the application, restore a backup
3. Configure the queues in supervisor
4. Configure the scheduler
5. Deploy new code to the server

## Configuration

1. Clone this repository to your local machine
2. Create a server in your provider
2. Put the ssh pem key of the server in the secrets directory and rename it to laravel-ansible.pem
3. Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) in your local machine
4. Configure your remote user in group_vars/all.yml and the rest of the variables of your project
5. You can restore a database, set the server timezone, your db credentials, and the domain name of the app
6. Create a rsa key pair with ssh-keygen, then add the public key to the repository deploy keys in the git server config.
7. Put the private key in the included secrets directory.

## Usage
In the terminal `ansible-playbook 01-provision.yml` to install all the packages needed for a laravel app

In the terminal `ansible-playbook 02-config.yml` to configure nginx and restore a db backup if you have one, check the group vars, and put the backup
in the secrets directory

In the terminal `ansible-playbook 03-deployment.yml` to install the Laravel project in the server, create a file named punto_env.j2 in the roles/code/templates dir
to copy the environmental variables for the first time only.

In the terminal `ansible-playbook 04-finish.yml` to install the Laravel scheduler in the server, and configure supervisor to keep the queues running
if you have any additional supervisor configs put them in the roles/supervisor-config/templates/ dir

Copy the .env into roles/code/templates/punto_env.j2


At the moment it only works with AWS Graviton instances, but it only needs little tweaks 
to works in other platforms.

Also multisite per server in on the way.