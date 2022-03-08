FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TMPDIR=/tmp \
    TERM=linux \
    JACK_NO_AUDIO_RESERVATION=1 \
    JACK_PROMISCUOUS_SERVER=audio \
    JACK_SAMPLE_RATE=48000 \
    JACK_PERIOD=128

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates locales vim git wget net-tools \
                                                  jackd2 alsa-utils libjack-jackd2-dev libqt5network5 mpg123 ecasound \
    && locale-gen en_US.UTF-8 \
    && usermod -a -G audio root 

# Install jacktrip
RUN export ARCH=`dpkg --print-architecture` \
    && cd ${TMPDIR} \
    && wget --progress=bar:force:noscroll -O ${TMPDIR}/jacktrip.tgz https://files.jacktrip.org/binaries/${ARCH}/jacktrip-v1.4.0-rc.2-ef45722d5d4c-${ARCH}.tar.gz \
    && tar xzvf jacktrip.tgz \
    && rm jacktrip.tgz \
    && install -m 755 ./jacktrip "/usr/local/bin"

COPY audio.conf /etc/security/limits.d/audio.conf
COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod +x /sbin/entrypoint.sh

EXPOSE 4464

CMD ["/sbin/entrypoint.sh"]
