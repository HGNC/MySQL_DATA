FROM debian:latest AS builder

WORKDIR /tmp/data
COPY ./data.tar.* ./

RUN test -f data.tar.gz || { echo 'ERROR: db_data build requires data.tar.gz (see db_data/README.md — HGNC OneDrive archive); place it in db_data/ and rebuild' >&2; exit 1; }

RUN bash -c "tar -xzvf ./data.tar.gz -C ." && \
	rm ./data.tar.gz

# --------------------------------------------
FROM debian:latest

VOLUME /var/lib/mysql
COPY --from=builder /tmp/data /var/lib/mysql
