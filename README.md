## Installation

PostgreSQL Installation
Visit the PostgreSQL official website: https://www.postgresql.org/download/.

Choose your operating system and follow the installation instructions for PostgreSQL.

pgAdmin Installation
Visit the pgAdmin official website: https://www.pgadmin.org/download/.

Select your platform (Windows, macOS, or Linux) and download the appropriate installer.

Follow the installation instructions for pgAdmin.

## Configuration

PostgreSQL Configuration
Start the PostgreSQL server (the service might be named "PostgreSQL" or "postgresql-x.x" where "x.x" is the version number).

By default, PostgreSQL comes with a "postgres" user. You need to set a password for this user.
By default, PostgreSQL listens on localhost (127.0.0.1). If you want to allow remote connections, configure the listen_addresses setting in the PostgreSQL configuration file (postgresql.conf).

pgAdmin Configuration
Launch pgAdmin after installation.

Create a new server connection:

Provide a name for the connection.
In the "Host name/address" field, enter the PostgreSQL server's hostname or IP address.
Enter the "Username" (usually "postgres").
Enter the password you set for the "postgres" user.
Save the connection settings.

## Connecting to PostgreSQL

Launch pgAdmin.
In the left panel, expand "Servers" and your server connection.
You can now browse databases, create tables, and run SQL queries through the user-friendly interface of pgAdmin.

## IPL Project steps

For IPL Sql Project,

- Open PGAdmin
- Expand servers
- Click on PGSQl and connect to server
- Right click on Databases and open create and creata a Database named IPL Project
- Right click on IPL Project, open Query tool and run both create matches table and create deliveries table queries as per Queries.sql file.
- Expand IPL Project, go to schema chose a table and import matches.csv for matches table and deliveries.csv for deliveries table.
- While importing keep the Headers option on.
- Once the process of import is successfully complete run the given two queries to verify the tables:
  - SELECT \* FROM matches
  - SELECT \* FROM deliveries

## Additional Resources

PostgreSQL Documentation: https://www.postgresql.org/docs/
pgAdmin Documentation: https://www.pgadmin.org/docs/
