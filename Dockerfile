FROM ubuntu

#RUN Ejecuta un comando
RUN apt-get update
RUN apt-get install -y python
RUN echo 1.0 >> /etc/version && apt-get install -y git && \
		apt-get install -y iputils-ping
RUN mkdir /datos

#WORKDIR: Directiva que indica y establece el directorio de trabajo, es como el cd de unix
WORKDIR /datos
RUN touch f1.txt

RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

#COPY: 
COPY index.html .
COPY app.log /datos

#ADD: 
ADD docs docs
ADD f* /datos/
ADD f.tar.xz .

#CMD: Directiva que indica el comando por defecto, solo puede haber un solo CMD, si existen mas, solo se toma el último
#CMD ["/bin/bash"]

#ENV: Declaracion de variables de entorno para el container
ENV dir=/data dir1=/data1
RUN mkdir $dir && mkdir $dir1

#ARG: Directiva para pasar argumentos o variables
#ARG dir2
#RUN mkdir $dir2
#ARG user
#ENV user_docker=$user
#ADD add_user.sh /datos1
#RUN /datos1/add_user.sh

#EXPOSE: Directiva que permite exponer puertos
RUN apt-get install -y apache2
EXPOSE 80
ADD entrypoint.sh /datos1

#VOLUME
ADD paginas /var/www/html
VOLUME ["/var/www/html"]


CMD /datos1/entrypoint.sh

#ENTRYPOINT: Directiva que no permite la sustición del comando final indicado por CMD,  solo puede haber un solo ENTRYPOINT, si existen mas, solo se toma el último
#ENTRYPOINT ["/bin/bash"]





