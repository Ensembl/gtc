FROM ubuntu
EXPOSE 8000/tcp

ARG USERNAME***REMOVED***
ARG USER_UID***REMOVED***
ARG USER_GID=$USER_UID

#Setting Proxies
ARG HTTP_PROXY***REMOVED***
ARG HTTPS_PROXY***REMOVED***
ARG http_proxy***REMOVED***
ARG https_proxy***REMOVED***

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

COPY release/target/gtc /home/$USERNAME/
COPY dist/gtc /home/$USERNAME/dist
WORKDIR /home/$USERNAME
CMD ROCKET_ENV=production ./gtc
