FROM mysql

ENV MYSQL_DATABASE python_ecommerce
ENV MYSQL_ROOT_PASSWORD 000

# Add the content of the sql-scripts/ directory to your image
# All scripts in docker-entrypoint-initdb.d/ are automatically
# executed during container startup
COPY ./scripts/ /docker-entrypoint-initdb.d/
