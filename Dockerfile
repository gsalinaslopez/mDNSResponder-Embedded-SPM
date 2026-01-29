FROM swift:latest

# RUN apt-get update && apt-get install -y git make gcc libmbedtls-dev
# 
RUN cd /home/ubuntu/ \
    && git clone https://github.com/apple-oss-distributions/mDNSResponder \
    # && cd mDNSResponder/mDNSPosix/ \
    # && make os=linux
