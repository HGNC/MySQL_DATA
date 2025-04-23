FROM debian:latest AS builder

WORKDIR /tmp/data
COPY ./data.tar.* .

RUN if [ -f "./data.tar.gz" ]; then \
	bash -c "tar -xzvf ./data.tar.gz -C ." && \
	rm ./data.tar.gz; \
fi

# --------------------------------------------
FROM debian:latest

VOLUME /var/lib/mysql
COPY --from=builder /tmp/data /var/lib/mysql
