# Nimble Streamer Installation Script (Ubuntu 20.04)

This script automates the installation and basic configuration of **Nimble Streamer** on.
- install_nimble-20.04.sh  -  for Ubuntu 20.04
- install_nimble-22.04.sh  -  for Ubuntu 22.04

---

## Preparation

Before running the script:

## **Update the system packages** (especially on a fresh VM):
```bash
sudo apt-get update
sudo apt-get dist-upgrade -y
```

## **Make the script executable:**
```bash
chmod +x install_nimble.sh
```

## **Running the script**
Run the script with `sudo`:
```bash
sudo ./install_nimble.sh
```

## **Registering with WMS Panel**
After installing Nimble, register your server with [WMSPanel](https://wmspanel.com/account/sign_up):
Create an account (if you haven’t already).
On the server, run the registration utility and enter your WMSPanel credentials:
```bash
sudo /usr/bin/nimble_regutil
```

## **After Installation**
Reboot the server:
```bash
sudo reboot
```
Open necessary ports for streaming (adjust as needed):
```bash
sudo ufw allow 44401:44420/udp
sudo ufw allow 55501:55520/udp
```
You may need to adjust the ports depending on your streaming setup.

