ARG VAULT_IMAGE_NAME
ARG VAULT_VERSION

FROM ${VAULT_IMAGE_NAME}:${VAULT_VERSION}

WORKDIR /tmp/vault/

RUN apk add --no-cache jq

ADD ./run.sh ./

ENTRYPOINT [ "sh" ]
CMD [ "./run.sh" ]
