FROM ubuntu:16.04

# add from local directory
# ADD ./xv6-02-26 /xv6-02-26
RUN apt-get -qq update && \
    # --no-install-recommends reduces the Image size by almost 15%,
    # but in our case git needs --reinstall ca-certificates to work
    apt-get install -y --no-install-recommends --reinstall ca-certificates \
                    git \
                    make\
                    gcc-multilib\
                    qemu-system\
                    
    &&git clone https://github.com/mit-pdos/xv6-public.git  xv6-02-26 \
    &&chmod +x xv6-02-26/*.pl \

####
#    5 lines for general cleanning, -15% in size  
    &&apt-get purge -qq git \
    &&apt-get autoremove --purge -qq \
    &&apt-get clean -qq &&rm -rf /var/lib/apt/lists/* \
    &&rm -rf /tmp/* /var/tmp/* \
    &&rm -rf /usr/share/man/* /usr/share/doc/*

WORKDIR /xv6-02-26

CMD ["/bin/bash"]

