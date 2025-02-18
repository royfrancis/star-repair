FROM python:3.10-bookworm
LABEL Description="star repair for pairing heavy and light chains"
LABEL Maintainer="roy.francis@nbis.se"
LABEL org.opencontainers.image.source="https://github.com/royfrancis/star-repair"

WORKDIR /work/star-repair
COPY . .
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip cache purge && \
    python setup.py install && \
    rm -rf /work/star-repair environment.yml
WORKDIR /work
ENTRYPOINT ["repair"]

# build
# docker build -t ghcr.io/royfrancis/star-repair:1.1 .
#
# multiplatform build
# docker buildx build --platform=linux/arm64,linux/amd64 -t ghcr.io/royfrancis/star-repair:1.1 -t ghcr.io/royfrancis/star-repair:latest --push -f Dockerfile .
#
# tag
# docker tag ghcr.io/royfrancis/star-repair:1.1 ghcr.io/royfrancis/star-repair:latest
#
# run repair
# docker run --rm ghcr.io/royfrancis/star-repair:latest
#
# run with volume
# docker run --rm -v ${PWD}:/work -u $(id -u):$(id -g) ghcr.io/royfrancis/star-repair:latest
#
# example 
# docker run --rm -v ${PWD}:/work -u $(id -u):$(id -g) ghcr.io/royfrancis/star-repair:latest analyze -i repair-counts.tsv -ap "^(IGH)" -bp "^(IGL)|^(IGK)" -mxo 5 -x 5 -b 100 -nb 1 -e 1500
#
# interactive shell
# docker run --rm -ti ghcr.io/royfrancis/star-repair:latest bash
