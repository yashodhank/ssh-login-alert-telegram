## Alert via telegram when user logon via SSH

Work on all popular linux system (Debian, Ubuntu, Arch Linux etc..)

![Example](mgs.png)

### Requirement
- curl
- git (much easy to install)

### Install
1) Clone or download to /opt/ folder
```cd /opt/ && git clone https://github.com/yashodhank/ssh-login-alert-telegram```

2) Edit two configuration variables by editing credentials.config:
```nano /opt/ssh-login-alert-telegram/credentials.config```

3) Add this script when user connect with the deploy script:
```bash /opt/ssh-login-alert-telegram/deploy.sh```

4) Confirm that the script is working by logging you to ssh again.


### Install with Ansible

If you have many servers go check: https://github.com/MyTheValentinus/Deploy-Telegram-SSH-Alerting-with-Ansible (fork of initial @stylernico work)

#### Special Thanks to https://github.com/MyTheValentinus & all the contributors.
