FROM ubuntu:disco

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y avahi-daemon

RUN apt-get install -y \
  build-essential git autotools-dev autoconf automake libtool gettext gawk \
  gperf antlr3 libantlr3c-dev libconfuse-dev libunistring-dev libsqlite3-dev \
  libavcodec-dev libavformat-dev libavfilter-dev libswscale-dev libavutil-dev \
  libasound2-dev libmxml-dev libgcrypt20-dev libavahi-client-dev zlib1g-dev \
  libevent-dev libplist-dev libsodium-dev libjson-c-dev libwebsockets-dev

RUN git clone https://github.com/ejurgensen/forked-daapd.git \
  && cd forked-daapd \
  && autoreconf -i \
  && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
  && make \
  && make install

# Run container
ADD image/run.sh /root/run.sh
VOLUME /config /music
EXPOSE 3689 6600
CMD ["/root/run.sh"]
