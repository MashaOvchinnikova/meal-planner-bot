FROM ubuntu:latest
LABEL authors="masha"

ENTRYPOINT ["top", "-b"]