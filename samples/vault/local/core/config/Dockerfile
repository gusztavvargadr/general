ARG VAULT_IMAGE_NAME
ARG VAULT_VERSION

ARG CONSUL_TEMPLATE_IMAGE_NAME
ARG CONSUL_TEMPLATE_VERSION

FROM ${CONSUL_TEMPLATE_IMAGE_NAME}:${CONSUL_TEMPLATE_VERSION} AS consul-template

FROM ${VAULT_IMAGE_NAME}:${VAULT_VERSION}

COPY --from=consul-template /bin/consul-template /bin/

WORKDIR /tmp/vault/

ADD ./*.sh ./
ADD ./*.hcl ./
