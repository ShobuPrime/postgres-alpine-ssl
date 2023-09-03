# Postgres with SSL on Alpine (Docker Image)

This Docker image is based on the official [Postgres Alpine image](https://hub.docker.com/_/postgres) and is configured to support SSL out of the box.

## Features

- Built on top of the official Postgres Alpine image
- SSL support enabled by default
- Automatic configuration and permission fixing for SSL certificates

## Quick Start

### Using Docker CLI

Pull the image from Docker Hub or build it locally.

```bash
docker pull postgres-alpine-ssl:[tag]
```

Or build:

```bash
docker build -t postgres-alpine-ssl:[tag] .
```

Run the image, specifying the SSL certificate and private key:

```bash
docker run -v /path/to/ssl:/ssl -e POSTGRES_PASSWORD=mysecretpassword postgres-alpine-ssl:[tag]
```

### Using docker-compose

Create a `docker-compose.yml` file:

```yaml
version: '3'
services:
  postgres:
    image: postgres-alpine-ssl:[tag]
    environment:
      POSTGRES_PASSWORD: mysecretpassword
    volumes:
      - /path/to/ssl:/ssl
```

Run the services:

```bash
docker-compose up
```

## Configuration

### Environment Variables

Inherit all the [original environment variables](https://hub.docker.com/_/postgres) from the Postgres image.

### Volumes

- `/.ssl/fullchain.pem`: Your SSL certificate
- `/.ssl/privkey.pem`: Your SSL private key

## Scripts

### `postgres_ssl.sh`

This script updates the PostgreSQL configuration to enable SSL and use the provided SSL certificate and private key. It modifies `postgresql.conf` and reloads Postgres to apply the changes.

### `ssl_permissions.sh`

This script fixes the permissions and ownership for the SSL certificate and private key to ensure they are securely accessed by Postgres.

It runs conditionally when the user is root, copying the certificate and private key from `/.ssl` to `/etc/ssl/postgres`, and updates their permissions and ownership.

## Usage

You can use this image as a base image in your Dockerfile:

```Dockerfile
FROM postgres-alpine-ssl:[tag]
# Your instructions here
```

## Contributing

Contributions are welcome! Please submit a Pull Request or open an issue for any enhancements, bugs, or other improvements.

## License

This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html).

---
