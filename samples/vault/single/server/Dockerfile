ARG VAULT_IMAGE_NAME
ARG VAULT_VERSION

FROM ${VAULT_IMAGE_NAME}:${VAULT_VERSION}

WORKDIR /vault/build/

ADD ./*.hcl ./
ADD ./build.sh ./
RUN sh ./build.sh

ADD ./ ./

WORKDIR /

CMD [ "server" ]
