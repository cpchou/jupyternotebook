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
RUN pip3 install jupyter
RUN pip3 install yfinance
RUN pip3 install bs4
RUN pip3 install imgkit
RUN pip3 install seaborn
RUN dnf install wget -y
RUN dnf install curl -y
RUN cd /tmp
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar -xzvf ta-lib-0.4.0-src.tar.gz
RUN cd ta-lib
RUN ./configure --prefix=/usr
RUN wget install make -y
RUN make
RUN make install
RUN pip3 install Ta-Lib



RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.allow_origin = '*'" >>  /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >>  /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.open_browser = False" >>  /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.rate_limit_window = 1000000000" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.iopub_data_rate_limit 1000000000" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.iopub_msg_rate_limit = 1000000000" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = argon2:$argon2id$v=19$m=10240,t=10,p=8$ADPNcDJRglk4ezGe0wAa9w$7Yp6yhV9uQ1CEWlyceGXtA" >> /root/.jupyter/jupyter_notebook_config.py
# jupyter notebook password 123456
RUN echo "{" > /root/.jupyter/jupyter_notebook_config.json
RUN echo "  "NotebookApp": {" >> /root/.jupyter/jupyter_notebook_config.json
RUN echo '    "password": "argon2:$argon2id$v=19$m=10240,t=10,p=8$ADPNcDJRglk4ezGe0wAa9w$7Yp6yhV9uQ1CEWlyceGXtA"' >> /root/.jupyter/jupyter_notebook_config.json
RUN echo "  }" >> /root/.jupyter/jupyter_notebook_config.json
RUN echo "}" >> /root/.jupyter/jupyter_notebook_config.json

ENTRYPOINT ["/usr/sbin/init"]
