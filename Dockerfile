
FROM public.ecr.aws/amazonlinux/amazonlinux:2

RUN yum -y update && \
    yum -y install coreutils procps-ng && \
    yum -y clean all && \
    rm -rf /var/cache/yum
    
CMD ["/bin/bash", "-c", "echo '--- ENV VARS INSIDE CONTAINER ---'; printenv | sort; echo '----------------------------------------'; sleep 7200"]
