# **3 PostgreSQL Installation**

## Requirement in this lab setup:
- MacOS arrch64/CentOS 7/Oracle Linux 9
- PostgreSQL version 15

## Installation: MacOS

**Downloan link:**

[PostgreSQL](https://www.postgresql.org/download/)

**Info after installation**
```note
Installation Directory: /Library/PostgreSQL/15
Server Installation Directory: /Library/PostgreSQL/15
Data Directory: /Library/PostgreSQL/15/data
Database Port: 5433
Database Superuser: postgres
Operating System Account: postgres
Database Service: postgresql-15
Command Line Tools Installation Directory: /Library/PostgreSQL/15
pgAdmin4 Installation Directory: /Library/PostgreSQL/15/pgAdmin 4
Stack Builder Installation Directory: /Library/PostgreSQL/15
Installation Log: /tmp/install-postgresql.log
```

**Setup PostgreSQL Environment Profile in MacOS Terminal:**

```bash
vi ~/.zshrc 
# ==================================================
# PostgreSQL Environment
# ==================================================

# ==================================================
# PostgreSQL Environment
# ==================================================

# PostgreSQL 15
export PGHOME="/Library/PostgreSQL/15"
export PGDATA="/Library/PostgreSQL/15/data"

```

**Check Postgres process:**

```bash
 ps aux | grep postgres
```

```bash
 cd Do

```

**Start/Stop Postgres process:**

```bash
 sudo -u postgres /Library/PostgreSQL/15/bin/pg_ctl start -D /Library/PostgreSQL/15/data

 sudo -u postgres /Library/PostgreSQL/15/bin/pg_ctl stop -D /Library/PostgreSQL/15/data

```

**Modify configuration:**

```bash
 # Allowing incomming connections from remote host, verify port when installing, turn on AUTOVACUUM
 su -
 cd /Library/PostgreSQL/15/data

 vi postgresql.conf

 listen_addresses = '*' 
 port = 5433
 autovacuum = on	
```

```bash
 vi pg_hba.conf 
 # Add by Administrator
 host 	all		all		0.0.0.0./0		md5
```


## **Installation: Oracle Linux 9**

### **OS configuration:**

```OS configuration
# VirtualBox Linux - Bridged Network + SSH + VS Code

## 1. Configure Bridged Network

VirtualBox:

VM -> Settings -> Network
Attached to: Bridged Adapter
Name: MacBook Wi-Fi/Ethernet

## 2. Check Linux VM IP

ip addr
hostname -I

192.168.10.47


## 3. Enable SSH
sudo systemctl enable --now sshd
sudo systemctl status sshd

SSH default port: `22`

## 4. Configure Hostname
sudo hostnamectl set-hostname ol9-ol9-postgres01
hostname

Configure `/etc/hosts`:

sudo vi /etc/hosts

192.168.10.47    ol9-ol9-postgres01

## 5. Test SSH from MacBook
ping 192.168.10.47
ssh ponleu@192.168.10.47

## 6. Configure VS Code SSH Host
Edit on MacBook:

vi ~/.ssh/config
Add:
Host ol9-postgres01
    HostName 192.168.10.47
    Port 22
    User ponleu

Test:
ssh ol9-postgres01

VS Code:
Remote Explorer -> SSH -> ol9-postgres01

## 7. Test Internet from VM
ip route
ping -c 3 8.8.8.8
ping -c 3 google.com

## Network Flow

MacBook
   |
   | SSH :22
   v
Linux VM (Bridged)
192.168.10.47
```

---

**Download link**: https://www.postgresql.org/download/linux/redhat/

### **Install PostgreSQL:**
```yum
# Install the repository RPM:
sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-aarch64/pgdg-redhat-repo-latest.noarch.rpm

# Install PostgreSQL:
sudo dnf install -y postgresql15-server

# Optionally initialize the database and enable automatic start:
sudo /usr/pgsql-15/bin/postgresql-15-setup initdb
sudo systemctl enable postgresql-15
sudo systemctl start postgresql-15
```
**Check Postgres Process after Installation:**
```bash
ps -ef | grep postgres
/usr/pgsql-15/bin/postmaster -D /var/lib/pgsql/15/data/
```

**Modify configuration:**


```bash
 # Allowing incomming connections from remote host, verify port when installing, turn on AUTOVACUUM
 su -
 cd /var/lib/pgsql/15/data/

 vi postgresql.conf

 listen_addresses = '*' 
 port = 5432
 autovacuum = on	
```

```bash
 vi pg_hba.conf 
 # Add by Administrator
 host 	all		all		0.0.0.0/0		md5

 # Restart PostgreSQL
 sudo -u postgres /usr/pgsql-15/bin/pg_ctl restart  -D /var/lib/pgsql/15/data/
```

