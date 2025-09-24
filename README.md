<p align="center">
  <img src="img/inception.png" width="70%"/>
</p>

## 🚀 SYNOPSIS

The `inception` 42 project challenges students to harness the power of containerization to build a fully functional, modular infrastructure.

By leveraging Docker's capabilities, this project focuses on orchestrating multiple containers to create a robust, isolated environment where different services work seamlessly together.

From configuring a secure web server to managing a persistent database, the `inception` project emphasizes precision, security, and efficiency. 
This journey is not just about mastering the tools, but about understanding the critical architectural decisions that drive modern software deployment.

## 🛠️ PROJECT OVERVIEW

The Inception project is a system administration exercise focused on Docker and containerization. The project's goal is to set up a small infrastructure composed of different services using Docker Compose. Each service must run in its dedicated container, built from scratch using Dockerfiles.

Key project requirements:
- All containers must be built using Alpine Linux or Debian as the base image
- Each service must run in a dedicated container
- Docker volumes for database and website files
- Internal Docker network connecting the containers
- No usage of pre-built Docker images (except base images)

### 🐋 WHAT IS DOCKER ?

Docker is a platform that enables developers to develop, ship, and run applications in containers. Containers are lightweight, standalone executable packages that include everything needed to run an application: code, runtime, system tools, libraries, and settings.
Key Docker Concepts

- **Images**: Read-only templates used to create containers
- **Containers**: Runnable instances of Docker images
- **Dockerfile**: A script containing instructions to build a Docker image
- **Docker Compose**: A tool for defining and running multi-container applications
- **Volumes**: Persistent data storage mechanism for containers
- **Networks**: Communication channels between Docker containers

Mandatory Services
### NGINX

The NGINX container serves as the entry point to our application. It handles incoming HTTP/HTTPS requests and directs them to the appropriate service.

Implementation Requirements:

    Built from Alpine/Debian base image
    TLS/SSL protocol enabled (port 443 only)
    Redirects to WordPress website
    Custom configuration file

### MARIADB

The MariaDB container stores all the WordPress data in a persistent volume.

Implementation Requirements:

    Built from Alpine/Debian base image
    Data stored in a dedicated volume
    Secure configuration with environment variables
    No direct external access (internal network only)

### WORDPRESS

The WordPress container hosts the website itself, connecting to the MariaDB database.

Implementation Requirements:

    Built from Alpine/Debian base image
    PHP-FPM configuration (no Apache)
    wp-config.php properly configured
    Connection to MariaDB container
    Files stored in a dedicated volume

Bonus Services

Beyond the mandatory containers, the project allows for additional services to demonstrate advanced Docker capabilities:
#### Redis Cache

    Implements caching for WordPress
    Improves website performance

#### FTP Server

    Provides file transfer capability
    Connected to WordPress volume

#### Static Website

    Separate from WordPress
    Demonstrates multi-site configuration

#### Adminer/phpMyAdmin

    Database management interface
    Connected to MariaDB

#### Node.js Application

    Additional service demonstration
    Custom web application

## 📚 PROJECT STRUCTURE

```
inception/
├── Makefile                # Build automation
├── .env                    # Environment variables (not in git repo)
├── srcs/
│   ├── docker-compose.yml  # Service orchestration
│   ├── requirements/       # Service configurations
│   │   ├── nginx/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   ├── mariadb/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   ├── wordpress/
│   │   │   ├── Dockerfile
│   │   │   └── conf/
│   │   └── bonus/          # Bonus services
│   │       ├── redis/
│   │       ├── ftp/
│   │       ├── static_site/
│   │       ├── adminer/
│   │       └── nodejs/
└── README.md               # Project documentation
```

## ⚙️ USAGE

Prerequisites

    Docker Engine
    Docker Compose
    Make (optional, for using the Makefile)

Clone the repo:

```bash
git clone https://github.com/maitreverge/inception.git
cd inception
```

Create a .env file in the project root with necessary environment variables:

```
DOMAIN_NAME=yourdomain.com

# MariaDB
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
MYSQL_PASSWORD=secure_password
MYSQL_ROOT_PASSWORD=very_secure_root_password

# WordPress
WP_TITLE="My WordPress Site"
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=admin_password
WP_ADMIN_EMAIL=admin@example.com
```

Build and start the services
```bash
make up
# OR without Makefile
docker-compose -f srcs/docker-compose.yml up -d --build
```
  
Access your WordPress site at https://yourdomain.com


## 🤝 CONTRIBUTION
Contributions are open, open a Github Issue or submit a PR 🚀
