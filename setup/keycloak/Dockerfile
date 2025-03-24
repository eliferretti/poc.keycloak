FROM quay.io/keycloak/keycloak:latest

ENV KEYCLOAK_USER=admin
ENV KEYCLOAK_PASSWORD=admin

EXPOSE 8080
CMD ["start-dev", "--http-port=8080", "--http-host=0.0.0.0"]