FROM postgres:15-alpine

# Add Postgres SSL custom script
COPY ./postgres_ssl.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/postgres_ssl.sh

# Copy script to fix SSL permissions
COPY ./ssl_permissions.sh /ssl_permissions.sh

# Prepend the SSL permission commands to /docker-entrypoint.sh
RUN head -n 1 /usr/local/bin/docker-entrypoint.sh > /tmp/temp.sh && \
    tail -n +2 ./ssl_permissions.sh >> /tmp/temp.sh && \
    tail -n +2 /usr/local/bin/docker-entrypoint.sh >> /tmp/temp.sh && \
    mv /tmp/temp.sh /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# Clean cruft
RUN rm /ssl_permissions.sh
