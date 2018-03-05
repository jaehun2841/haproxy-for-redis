FROM haproxy:1.8.4

MAINTAINER Carrey (jaehun.lee@ticketlink.co.kr)

## Copy Redis File
## 복사/추가 하는파일의 Container내 경로는 항상 절대경로로 작성하여야 한다.
RUN rm -rf /usr/local/bin/docker-entrypoint.sh
ADD haproxy.cfg /usr/local/bin/haproxy.cfg
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

## change access authority
RUN chmod 755 /usr/local/bin/haproxy.cfg
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh

#RUN chown redis:redis /usr/local/bin/haproxy.cfg
#RUN chown redis:redis /usr/local/bin/docker-entrypoint.sh

EXPOSE $MASTER_PORT $CLIENT_PORT
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/bin/haproxy.cfg"]
