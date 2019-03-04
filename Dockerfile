# inspired by tianon/docker-postgres-upgrade

FROM postgres:8.4 AS pg84

FROM postgres:9.6.11

RUN localedef -i da_DK -c -f UTF-8 -A /usr/share/locale/locale.alias da_DK.UTF-8
ENV LANG da_DK.utf8

COPY --from=pg84 /usr/lib/postgresql/8.4 /usr/lib/postgresql/8.4
COPY --from=pg84 /usr/share/postgresql/8.4 /usr/share/postgresql/8.4
COPY --from=pg84 /usr/lib/x86_64-linux-gnu/libssl.so.1.0.0 /usr/lib/x86_64-linux-gnu/libssl.so.1.0.0
COPY --from=pg84 /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0

ENV PGBINOLD /usr/lib/postgresql/8.4/bin
ENV PGBINNEW /usr/lib/postgresql/9.6/bin

ENV PGDATAOLD /var/lib/postgresql/8.4/data
ENV PGDATANEW /var/lib/postgresql/9.6/data

RUN mkdir -p "$PGDATAOLD" "$PGDATANEW" \
	&& chown -R postgres:postgres /var/lib/postgresql

WORKDIR /var/lib/postgresql

COPY docker-upgrade /usr/local/bin/

ENTRYPOINT ["docker-upgrade"]

# recommended: --link
CMD ["pg_upgrade", "'--link"]
