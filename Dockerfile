FROM ubuntu:24.04

ENV DEBIAN_FRONTED=noninteractive \
    VNC_PORT=5901 \
    DISPLAY=:1 \
    USERNAME=developer \
    PASSWORD=developer

RUN apt-get update && apt-get install -y \
#    xfce4 xfce4-gooties \
    tigervnc-standalone-server tigervnc-tools \
    openssh-server \
    curl wget sudo \
    python3 python3-pip \
    dbus-x11 x11-xserver-utils \
    && rm -rf /var/lib/apt/lists/*

#RUN userad -m -s /bin/bash $USERNAME && \
#    echo "$USERNAME:$PASSWORD" | chpasswd && \
#    usermod -aG sudo $USERNAME

#RUN mkdir -p /home/$USERNAME/.vnc && \
#    echo $PASSWORD | vncpasswd -f > /home/$USERNAME/.vnc/passwd && \
#    chmod 600 /home/$USERNAME/.vnc/passwd && \
#    chown -R $USERNAME:$USERNAME /home/$USERNAME/.vnc

#RUN echo "startxfce4 &" > /home/$USERNAME/.vnc/xstartup && \
#    chmod +x /home/$USERNAME/.vnc/xstartup

RUN apt-get update && apt-get install -y curl && \
    curl -fsSL -o /tmp/code.deb "https://code.visualstudio.com/docs/?dv=linux64_deb" 
#    apt-get install -y /tmp/code.deb && \
#    rm -rf /tmp/code.deb


EXPOSE 5901 22

CMD ["/bin/bash", "-c", "service ssh start && su - $USERNAME -c 'vncserver -geometry 1280x800 -depth 24' && tail -f /dev/null"]
