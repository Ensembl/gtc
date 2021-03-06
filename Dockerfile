FROM ubuntu
EXPOSE 8000/tcp

# USERNAME, USER_UID and HTTP_PROXY must be specify with --build-args
ARG USER_UID
ARG USERNAME
ARG USER_GID=$USER_UID


#Setting Proxies
ARG HTTP_PROXY
ARG HTTPS_PROXY=$HTTP_PROXY
ARG http_proxy=$HTTP_PROXY
ARG https_proxy=$HTTP_PROXY

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

COPY target/release/gtc /home/$USERNAME/
COPY dist/gtc /home/$USERNAME/dist
WORKDIR /home/$USERNAME
CMD ROCKET_ENV=production ./gtc
