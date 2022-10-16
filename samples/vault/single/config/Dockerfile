ARG TERRAFORM_IMAGE_NAME
ARG TERRAFORM_VERSION

FROM ${TERRAFORM_IMAGE_NAME}:${TERRAFORM_VERSION}

WORKDIR /tmp/vault/

ENV TF_INPUT=false
ENV TF_IN_AUTOMATION=true

ADD ./terraform.tf ./
RUN terraform init

ADD ./*.tf ./
ADD ./*.hcl ./

CMD [ "apply", "-auto-approve" ]
