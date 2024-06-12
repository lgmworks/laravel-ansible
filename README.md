# Laravel-ansible

## This Project Can:
1. Provision the server, php, nginx, supervisor, redis, node, mysql
2. Configure nginx and php to serve the application, restore a backup
3. Configure the queues in supervisor
4. Configure the scheduler
5. Deploy new code to the server

## Configuration

1. Clone this repository to your local machine.
2. Create a server in your provider.
3. Create an inventory.ini file based on the example and add your server IP there.
4. Place the server's ssh pem key in the secrets directory and rename it to laravel-ansible.pem.
5. Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) on your local machine.
6. Configure your remote user in `group_vars/all.yml` and set the remaining variables for your project.
7. Optionally, you can restore a database, set the server timezone, your db credentials, and the domain name of the app.
8. Create an RSA key pair with `ssh-keygen`, then add the public key to the repository deploy keys in the git server config.
9. Place the private key in the included secrets directory.
10. Copy the `.env` file into `roles/code/templates/punto_env.j2`.
11. Configure your email for the ssl certificates in `group_vars/all.yml`

## Usage
1. Run `ansible-playbook 01-provision.yml` in the terminal to install all the packages needed for a Laravel app.
2. Run `ansible-playbook 02-config.yml` in the terminal to configure nginx and restore a database backup if you have one. Check the group vars and place the backup in the secrets directory.
3. Run `ansible-playbook 03-deployment.yml` in the terminal to install the Laravel project on the server. Create a file named `punto_env.j2` in the `roles/code/templates` directory to copy the environmental variables for the first time only.
4. Run `ansible-playbook 04-finish.yml` in the terminal to install the Laravel scheduler on the server and configure supervisor to keep the queues running. If you have any additional supervisor configs, place them in the `roles/supervisor-config/templates/` directory.



## Notes
Currently, this setup only works with AWS Graviton instances, but it requires only minor tweaks to work on other platforms. Multisite per server is also in progress.
