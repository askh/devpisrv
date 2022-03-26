FROM python
EXPOSE 3141
RUN apt update && apt upgrade -y
RUN useradd -d /home/devpisrv -m -s /bin/bash -U devpisrv
RUN mkdir -p -m 750 /var/local/devpisrv && chown devpisrv:devpisrv /var/local/devpisrv
COPY requirements.txt /tmp/
USER devpisrv:devpisrv
RUN pip3 install -U pip
ENV PATH="/home/devpisrv/.local/bin:${PATH}"
RUN pip install -U -r /tmp/requirements.txt
RUN devpi-init --serverdir /var/local/devpisrv
CMD devpi-server --serverdir /var/local/devpisrv --host 0.0.0.0