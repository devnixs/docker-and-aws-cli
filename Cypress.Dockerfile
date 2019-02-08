FROM node:10.13

RUN apt-get update && \
  apt-get install -y \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    xvfb

# versions of local tools
RUN node -v
# NPM version should already be pretty new (> 6.4.0)
RUN npm -v
RUN yarn -v

# Install AWS Dependencies

ENV DOCKERVERSION=18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

RUN apt-get update
RUN apt-get install curl -y

RUN curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN docker -v
RUN docker-compose -v

RUN apt-get update && apt-get -y install python-pip
RUN pip install awscli

RUN aws --version

ENTRYPOINT ["/bin/sh"]