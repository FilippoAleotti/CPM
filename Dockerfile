FROM filippoaleotti/opencv-ubuntu
USER root

RUN mkdir /CPM
RUN useradd -d /CPM user

COPY . /CPM
WORKDIR /CPM
