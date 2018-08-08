FROM debian

ENV PATH=$PATH:/root/.nimble/bin

RUN apt update && \
      apt -y install libc-dev gcc curl git perl mingw-w64 libzip-dev wget \
      && \
      rm -rf /var/cache/apt/;

RUN apt -y install xz-utils make
RUN CHOOSENIM_CHOOSE_VERSION="0.18.0" curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- "-y"

ADD scripts /scripts
ADD project /src

WORKDIR /src

CMD /scripts/build.sh
