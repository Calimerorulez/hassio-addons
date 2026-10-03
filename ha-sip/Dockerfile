ARG BUILD_FROM
FROM ${BUILD_FROM}
ENV LANG=C.UTF-8

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        binutils \
        build-essential \
        ffmpeg \
        git \
        libopus-dev \
        libssl-dev \
        python3 \
        python3-dev \
        python3-pip \
        swig \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt --break-system-packages

RUN git clone --depth 1 --branch 2.17 https://github.com/pjsip/pjproject.git /tmp/pjproject

WORKDIR /tmp/pjproject

RUN set -xe \
    && ./configure CFLAGS="-O3 -DNDEBUG -fPIC" --enable-shared --disable-libwebrtc --with-ssl --with-opus=/usr \
    && make \
    && make dep \
    && make install \
    && cd pjsip-apps/src/swig \
    && make python \
    && make -C python install \
    && cd / \
    && rm -rf /tmp/pjproject \
    && ldconfig

COPY run.sh run-in-ha.sh run-standalone.sh /
RUN chmod a+x /run.sh /run-in-ha.sh /run-standalone.sh

COPY src/ /ha-sip/

WORKDIR /

CMD ["/run.sh"]
