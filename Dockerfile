FROM ubuntu:focal
MAINTAINER Thomas B. Mooney <tmooney@genome.wustl.edu>

LABEL \
  version="1.12" \
  description="bcftools image for use in Workflows"

RUN apt-get update && apt-get install -y \
  bzip2 \
  g++ \
  libbz2-dev \
  libcurl4-openssl-dev \
  liblzma-dev \
  make \
  ncurses-dev \
  wget \
  zlib1g-dev

ENV BCFTOOLS_INSTALL_DIR=/opt/bcftools
ENV BCFTOOLS_VERSION=1.12

WORKDIR /tmp
RUN wget https://github.com/samtools/bcftools/releases/download/$BCFTOOLS_VERSION/bcftools-$BCFTOOLS_VERSION.tar.bz2 && \
  tar --bzip2 -xf bcftools-$BCFTOOLS_VERSION.tar.bz2

WORKDIR /tmp/bcftools-$BCFTOOLS_VERSION
RUN make prefix=$BCFTOOLS_INSTALL_DIR && \
  make prefix=$BCFTOOLS_INSTALL_DIR install

WORKDIR /
RUN ln -s $BCFTOOLS_INSTALL_DIR/bin/bcftools /usr/bin/bcftools && \
  rm -rf /tmp/bcftools-$BCFTOOLS_VERSION

ENTRYPOINT ["/usr/bin/bcftools"]
