ARG VAULT_IMAGE_NAME
ARG VAULT_VERSION

FROM ${VAULT_IMAGE_NAME}:${VAULT_VERSION}

WORKDIR /tmp/vault/cli/

RUN apk add --no-cache jq net-tools

ADD ./cli/ ./
RUN chmod +x ./*.sh

ENTRYPOINT [ "./config/env.sh" ]
CMD [ "sh" ]
