FROM postgres:9.5

MAINTAINER Ikenna N. Okpala <me@ikennaokpala.com>
ARG BUILD_DATE
ARG VCS_REF
# i.e
# BUILD_DATE `date -u +"%Y-%m-%dT%H:%M:%SZ"`
# VCS_REF `git rev-parse --short HEAD`
LABEL org.label-schema.build-date=$BUILD_DATE \
       org.label-schema.docker.dockerfile="/Dockerfile" \
       org.label-schema.license="GNU GENERAL PUBLIC LICENSE" \
       org.label-schema.name="NLS-PG docker container (gfb)" \
       org.label-schema.url="http://globalfoodbook.com/" \
       org.label-schema.vcs-ref=$VCS_REF \
       org.label-schema.vcs-type="Git" \
       org.label-schema.vcs-url="https://github.com/globalfoodbook/nls-pg.git"

ENV POSTGRES_VERSION 9.5
ENV POSTGRES_IP 127.0.0.1
ENV POSTGRES_PORT 5432
ENV POSTGRES_MAIN_USER postgres
ENV POSTGRES_USER ikennaokpala
ENV POSTGRES_PASSWORD 12345678
ENV POSTGRES_DB nutrition_development
ENV NUT_PG_DSN postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_IP/$POSTGRES_DB?sslmode=disable
ENV PATH /usr/local/bin:/usr/lib/postgresql/$POSTGRES_VERSION/bin/:$PATH

RUN mkdir -p /tmp/psql_data/

ADD templates/entrypoint.sh /etc/init.d/entrypoint.sh
ADD templates/pg_entrypoint.sh /etc/init.d/pg_entrypoint.sh

COPY templates/nutrition_sr26.sql /tmp/psql_data/
COPY templates/nutrition_sr26.archive /tmp/psql_data/
COPY templates/load_data.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/load_data.sh
RUN chmod +x /etc/init.d/pg_entrypoint.sh
RUN chmod +x /etc/init.d/entrypoint.sh

WORKDIR $HOME

EXPOSE $POSTGRES_PORT

# Setup the entrypoint
ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["/etc/init.d/entrypoint.sh"]
