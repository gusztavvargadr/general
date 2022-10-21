ARG TERRAFORM_IMAGE_NAME
ARG TERRAFORM_VERSION

FROM ${TERRAFORM_IMAGE_NAME}:${TERRAFORM_VERSION}

WORKDIR /tmp/vault/config/

ENV TF_INPUT=false
ENV TF_IN_AUTOMATION=true

ADD ./config/terraform.tf ./
RUN terraform init

ADD ./config/ ./

CMD [ "apply", "-auto-approve" ]
