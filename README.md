# How to install the Nibiru node

This manual describes how to install the Nolus node on your Linux box using a predefined Ansible playbook.

# Install Nolus node on Linux

## Minimum requirements

Linux box with 2 CPUand 4 GB of RAM

About 400 GB Disk free space

## Prepare your Linux server to run Ansible playbooks

It is necessary to do it only once. If you did it before, skip the docker and Ansible installation


### Install docker stuff to prepare the environment

Install from [here](https://github.com/zukudm/tools)

Also, you can do it without any scripts by yourself

<details>


Docker engine from [here](https://docs.docker.com/engine/install/)

Just select your Linux distributive. 

Docker compose from [here](https://docker-docs.netlify.app/compose/install/)
</details>

### Install Ansible

<details>

Connect to the Linux box, where you are going to run the node and run commands to install Ansible

In the case of Ubuntu run these commands:

```bash
 apt update -y
 apt install -y software-properties-common
 add-apt-repository --yes --update ppa:ansible/ansible
 apt install -y ansible
```

In case of other distributions of Linux, follow instructions from [here](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html)

</details>

## Fetch the repository with Ansible files and prepare to run the node on the Linux box

```bash
 apt update -y
 git clone https://github.com/zukudm/_nibiru_node.git
 cd ~/_nibiru_node
 ansible-galaxy install -r collections/requirements.yml
```

## Run Nibiru node

```bash
cd ~/_nibiru_node
ansible-playbook nibiru_setup.yml
```
## Run Nibiru new keys generation or recovery (default is new key generation)

```bash
cd ~/_nibiru_node
ansible-playbook nibiru_add-restore_keys.yml
```

After creating a new key, its information will be shown alongside the seed phrase. Make sure to write it down, as it is the only way to restore your keys.

For recovering run the playbook with an aditional parameter ask_recovery setting it to yes

```bash
cd ~/_nibiru_node
ansible-playbook -e ask_recovery=yes nibiru_add-restore_keys.yml
```
<details>
<summary>Recovering with AWX</summary>


Set parameter recovery by setting it in the variables field for nibiru_add-restore_keys.yml playbook:
```bash
recovery: put your mnemonic which consists from a lot of words here
```
</details>


## Upgrade to Validator

After starting the nibiru daemon, the chain will begin to sync to the network. The time to sync to the network will vary depending on your setup and the current size of the blockchain, but it could take a time

To get tokens, check out on the Discord server.

Wait for some time for synchronization and run the Validator upgrade. 

```bash
 cd ~/_nibiru_node
 ansible-playbook nibiru_upgrade_to_validator.yml
```


## Update

Run playbook nibiru_update.yml

```bash
 cd ~/_nibiru_node
 ansible-playbook nibiru_update.yml
```

## Remove

To remove the node from the server just log in and run

```bash
 cd ~/_nibiru_node
 ansible-playbook nibiru_remove.yml
 ```
 
 # List of Ansible playbooks:

nibiru_setup.yml - Setup Nibiru node within your Linux box. Run it from the root user. 

nibiru_add_restore_keys.yml - Run a new keys generation (or recovery).

nibiru_upgrade_to_validator.yml - Nibiru Upgrade to Validator.

nibiru_update.yml - Update Nibiru to the new version.

nibiru_remove.yml  - Remove all Nibiru data, suitable for all cases.

