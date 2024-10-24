# ARG BASE_IMAGE
# FROM ${BASE_IMAGE}
FROM saas:v1
COPY --chown=app:app . /home/app/src/

WORKDIR /home/app/src/

USER app