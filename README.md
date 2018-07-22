Summary
=======
Configure a linux development server using Ansible

Ansible Controller Requirements
===============================
- Ansible
- A hosts file with the server endpoint. For example:
```
[servers]
server-host-name.domain
```

Remote Server Requirements
==========================
- A linux user. Can be created with: `adduser --gecos "John Doe" jdoe`
- SSH access to that user
- Passwordless sudo for the user. Can be given by adding entry `jdoe ALL=(ALL) NOPASSWD: ALL` using command `sudo visudo`
- Server user name should match user name on controller
- Python (Required for Ansible)

Instructions
============
Run `run.sh -e git_user_name="<git_user_name>" -e git_user_email="<git_user_email>"`

Manual Steps
============
These steps are not yet automated :sweat_smile:

- Provision AWS access keys
- Provision Github SSH keys
- Provision gcloud access keys
