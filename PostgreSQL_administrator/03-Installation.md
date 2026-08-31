# 3 PostgreSQL Installation

## Requirement in this lab setup:
- MacOS arrch64
- PostgreSQL version 15

## Installation

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


## **Install PostgreSQL 15 on Oracle Linux 9**

Download link: https://www.postgresql.org/download/linux/redhat/

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