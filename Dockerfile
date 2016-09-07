FROM ubuntu:xenial
MAINTAINER Thomas B. Mooney <tmooney@genome.wustl.edu>

LABEL \
  version="1.3.1" \
  description="bcftools image for use in Workflows"

RUN apt-get update && apt-get install -y \
  bzip2 \
  g++ \
  make \
  ncurses-dev \
  wget \
  zlib1g-dev

ENV BCFTOOLS_INSTALL_DIR=/opt/bcftools

WORKDIR /tmp
RUN wget https://github.com/samtools/bcftools/releases/download/1.3.1/bcftools-1.3.1.tar.bz2 && \
  tar --bzip2 -xf bcftools-1.3.1.tar.bz2

WORKDIR /tmp/bcftools-1.3.1
RUN make prefix=$BCFTOOLS_INSTALL_DIR && \
  make prefix=$BCFTOOLS_INSTALL_DIR install

WORKDIR /
RUN ln -s $BCFTOOLS_INSTALL_DIR/bin/bcftools /usr/bin/bcftools && \
  rm -rf /tmp/bcftools-1.3.1

ENTRYPOINT ["/usr/bin/bcftools"]
