FROM filippoaleotti/opencv-ubuntu
USER root

RUN mkdir /workspace
RUN mkdir /workspace/CPM
RUN useradd -d /workspace user

COPY . /workspace/CPM
WORKDIR /workspace/CPM
RUN cmake .
RUN make

RUN mkdir /workspace/RIC
WORKDIR /workspace/RIC
RUN git clone https://github.com/YinlinHu/Ric.git
RUN mv Ric/* .
RUN rm -r Ric
WORKDIR /workspace/RIC
RUN make -f Makefile -j 7

WORKDIR /workspace