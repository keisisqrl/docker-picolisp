FROM alpine:3.7

RUN apk add --no-cache openssl curl gcc make openssl-dev musl-dev vim \
    && curl http://software-lab.de/picoLisp.tgz \
    |  tar xz \
    && cd /picoLisp \
    && curl http://software-lab.de/x86-64.linux.tgz \
    |  tar -xz \
    && make -C src64 \
    && make -C src64 clean \
    && make -C src64 \
    && make -C src64 clean \
    && make -C src tools gate \
    && make -C src clean \
    && apk del --no-cache curl gcc make openssl-dev musl-dev

WORKDIR /

RUN mv /picoLisp /usr/lib/picolisp \
    && ln -s /usr/lib/picolisp/bin/picolisp /usr/bin \
    && ln -s /usr/lib/picolisp/bin/pil /usr/bin

EXPOSE 80

CMD [ "pil", "+" ]
