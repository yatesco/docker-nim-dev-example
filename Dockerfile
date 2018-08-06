FROM debian

ENV PATH=$PATH:/opt/Nim/bin:/root/.nimble/bin

RUN apt update && \
      apt -y install libc-dev gcc curl git perl mingw-w64 \
      && \
      rm -rf /var/cache/apt/;

RUN mkdir -p /opt && cd /opt && \
      curl -LO https://github.com/nim-lang/Nim/archive/v0.18.0.tar.gz && \
      tar zxf v0.18.0.tar.gz && rm -f v0.18.0.tar.gz && \
      mv Nim-0.18.0 Nim && cd Nim && \
      git clone --depth 1 git://github.com/nim-lang/csources && \
      cd csources && sh build.sh && \
      cd .. && ./bin/nim c koch && ./koch boot -d:release && \
      nim e install_nimble.nims && \
      rm -rf /opt/Nim/tests;

ADD scripts /scripts
ADD project /src

WORKDIR /src

CMD /scripts/build.sh
