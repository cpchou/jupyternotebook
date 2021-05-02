FROM library/centos:8
ENV LANG zh_TW.UTF-8
ENV LANGUAGE zh_TW.UTF-8
#ENV LC_ALL zh_TW.UTF-8
ENV TZ=Asia/Taipei
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime

RUN dnf update -y
RUN dnf makecache -y
RUN dnf install gcc python3-devel -y
RUN dnf install python3-pip -y
RUN pip3 install requests
RUN pip3 install pandas
RUN pip3 install matplotlib
RUN pip3 install  jupyter

ENTRYPOINT ["/usr/sbin/init"]
