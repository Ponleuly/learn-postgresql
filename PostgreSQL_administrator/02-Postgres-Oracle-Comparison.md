# 02-Highlevel Comparison between Oracle and Postgresql

## OVERVIEW

- Oracle and PostgreSQL are both RDBMS databases.
- Both support core database concepts such as:
  - ACID properties
  - Concurrency control
  - Cost-Based Optimizer (CBO)
  - MVCC
  - Security
  - Compression
  - Auditing
- PostgreSQL has many Oracle-equivalent features, but some are
  implemented differently or provided through extensions.

### ORACLE VS POSTGRESQL - KEY FEATURE COMPARISON

1. Transaction Logging

- Oracle: Redo Log
- PostgreSQL: WAL (Write-Ahead Logging)
 > PostgreSQL WAL is comparable to Oracle Redo Log for transaction logging and physical backup/recovery.

2. Physical Backupx
- Oracle: RMAN
- PostgreSQL: pg_basebackup, Barman, pgBackRest
> pg_basebackup is included with PostgreSQL.
  Barman and pgBackRest are additional backup solutions.

3. Logical Backup

   Oracle:
       - Export/Import
       - Data Pump

   PostgreSQL:
       - pg_dump
       - pg_dumpall
       - pg_restore

   - PostgreSQL standard logical backup tools are client-side.

4. Tablespace

   - Both Oracle and PostgreSQL support tablespaces.
   - Their internal implementations are different.
   - The detailed differences are covered separately.

5. Large Object Storage

   Oracle:
       SecureFiles

   PostgreSQL:
       TOAST
       = The Oversized-Attribute Storage Technique

6. Storage Management

   Oracle:
       ASM (Automatic Storage Management)

   PostgreSQL:
       - No direct equivalent to Oracle ASM.

7. Partitioning

   PostgreSQL supports:
   - Range
   - Hash
   - List
   - Composite/multi-level partitioning

   - PostgreSQL partitioning is generally a subset of Oracle's
     partitioning capabilities.

8. Physical Replication

   Oracle:
       Data Guard

   PostgreSQL:
       Streaming Replication

9. Logical Replication

   Oracle:
       GoldenGate

   PostgreSQL:
       Logical Replication

10. RAC / Clustered Database

    Oracle:
        Real Application Clusters (RAC)

    PostgreSQL:
        - No direct equivalent to Oracle RAC.

11. Flashback

    Oracle:
        - Flashback Database
        - Flashback Table

    PostgreSQL:
        - No direct equivalent to Oracle Flashback.
        - Point-in-Time Recovery (PITR) can be used for recovery
          from situations such as an accidental table drop.

12. Procedural Language

    Oracle:
        PL/SQL

    PostgreSQL:
        PL/pgSQL

13. Compression

    - Both Oracle and PostgreSQL support compression.
    - PostgreSQL can use extensions to provide additional
      compression functionality.

14. Security

    Oracle examples:
    - Virtual Private Database (VPD)
    - Transparent Data Encryption (TDE)
    - Database Vault

    PostgreSQL examples:
    - Row-Level Security (RLS)
    - pgcrypto extension for cryptographic functionality

15. Monitoring

    Oracle:
        - Oracle Enterprise Manager (OEM)

    PostgreSQL:
        - pgAdmin
        - Nagios
        - Prometheus
        - Grafana

16. MVCC

    Both databases support:

        MVCC = Multiversion Concurrency Control

    Oracle:
        - Uses Undo to maintain previous versions of data.

    PostgreSQL:
        - Uses transaction IDs and row versions.

    - The concept is similar, but the internal implementation
      is different.

17. Connection Pooling

    Oracle:
        - Connection Manager
        - DRCP

    PostgreSQL:
        - PgBouncer
        - Pgpool-II

18. Remote Database Connections

    Oracle:
        Database Links (DB Links)

    PostgreSQL:
        Foreign Data Wrappers (FDW)

    FDWs can connect PostgreSQL to:

    - PostgreSQL databases
    - MySQL databases
    - Oracle databases
    - CSV files
    - AWS S3
    - Other external data sources

    Examples:
    - mysql_fdw -> MySQL
    - oracle_fdw -> Oracle
    - postgres_fdw -> PostgreSQL

    - FDWs are not limited to connecting databases only.

19. Performance Tuning

    Oracle provides many tuning tools, such as:
    - SQL Tuning Advisor
    - SQL Plan Baselines
    - AWR
    - ASH

    PostgreSQL does not have direct equivalents for all of these.

    PostgreSQL options include:
    - pg_hint_plan
        -> Allows optimizer hints.

    - pg_stat_statements
        -> Provides SQL statement performance statistics.

    - pg_profile
        -> Generates PostgreSQL performance reports.

    - pgBadger
        -> Analyzes PostgreSQL logs and generates reports.

20. Auditing

    - Both Oracle and PostgreSQL support auditing.

    PostgreSQL:
        pgaudit

    - pgaudit is an extension that provides additional
      PostgreSQL auditing capabilities.


POSTGRESQL EXTENSIONS

- A major strength of PostgreSQL is its rich extension ecosystem.
- Extensions add functionality that is not included in the
  PostgreSQL core.
- They allow PostgreSQL to be customized for specific requirements.

Examples:

    PostgreSQL
        +
    pg_hint_plan
        ->
    Query optimizer hints

    PostgreSQL
        +
    pg_stat_statements
        ->
    SQL performance statistics

    PostgreSQL
        +
    pgaudit
        ->
    Auditing

    PostgreSQL
        +
    pg_profile
        ->
    Performance reports

- PostgreSQL DBAs commonly rely on extensions for additional
  real-world functionality.


POSTGRESQL ACADEMIC HERITAGE

- PostgreSQL originated from the POSTGRES project at the
  University of California, Berkeley.
- Its academic and relational-database-theory heritage is
  reflected in PostgreSQL terminology.

PostgreSQL terminology:

    Relation
        = Table or Index

    Tuple
        = Row

    Attribute
        = Column


KEY TAKEAWAYS

- Oracle and PostgreSQL share many fundamental RDBMS concepts.
- Similar features do not necessarily mean identical
  implementations.
- PostgreSQL relies heavily on extensions to provide additional
  functionality.
- PostgreSQL has no direct equivalent to some Oracle technologies,
  such as ASM, RAC, and Flashback.
- PostgreSQL uses different approaches for MVCC, replication,
  backup, monitoring, and performance tuning.
- FDWs provide PostgreSQL with a flexible way to access external
  databases and data sources.
- Understanding Oracle-to-PostgreSQL terminology and feature
  correlations is important for Oracle DBAs transitioning to
  PostgreSQL.

IMPORTANT ORACLE DBA MAPPING

Oracle                  PostgreSQL
------------------------------------------------------------
Redo Log                WAL
RMAN                    pg_basebackup / Barman / pgBackRest
Export/Import           pg_dump / pg_restore
Tablespace              Tablespace
SecureFiles             TOAST
ASM                     No direct equivalent
Data Guard              Streaming Replication
GoldenGate              Logical Replication
RAC                     No direct equivalent
Flashback               PITR
PL/SQL                  PL/pgSQL
OEM                     pgAdmin / Prometheus / Grafana
DB Links                Foreign Data Wrappers
Connection Manager     PgBouncer / Pgpool-II
AWR / ASH               pg_profile / pg_stat_statements
SQL Tuning Advisor      pg_hint_plan
Auditing                pgaudit

################################################################
# END Section 2. Highlevel Comparison between Oracle and Postgresql
################################################################