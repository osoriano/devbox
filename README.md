Summary
=======
Configure a linux development server using Ansible

Host Requirements
=================
- Ansible
- Python
- A hosts file with the server endpoint. For example:
```
[servers]
server-host-name.domain
```

Server Requirements
===================
- A linux user. Can be created with: `adduser --gecos "John Doe" jdoe`
- SSH access to that user
- Passwordless sudo for the user. Can be given by adding entry `jdoe ALL=(ALL) NOPASSWD: ALL` using command `sudo visudo`
- Server user name should match user name on host machine

Instructions
============
Run `run.sh`
