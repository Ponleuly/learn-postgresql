# 3 PostgreSQL Installation

## Requirement in this lab setup:
- MacOS arrch64
- PostgreSQL version 15

## Installation

**Downloan link:**

[PostgrrSQL](https://www.postgresql.org/download/)

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
 sudo -u postgres /Library/PostgreSQL/18/bin/pg_ctl status -D /Library/PostgreSQL/18/data

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