#USE BLAST BINARIES FROM UMMIDOCK REPO 
FROM ummidock/blast_binaries:2.6.0-binaries 
WORKDIR /NGStools/
RUN apt-get update
RUN apt-get install psmisc
RUN apt-get install -y git make python-dev gcc wget libxml2-dev libxslt1-dev zlib1g-dev g++ build-essential mafft dos2unix

#INSTALL PIP 
RUN apt-get install -y python-pip  

#USE BLAST BINARIES FROM UMMIDOCK REPO 
FROM ummidock/blast_binaries:2.6.0-binaries 
WORKDIR /NGStools/
RUN apt-get update
RUN apt-get install psmisc
#RUN apt-get install -y git make python-dev gcc wget libxml2-dev libxslt1-dev zlib1g-dev g++ build-essential
RUN apt-get install -y git make python3 python3-pip libatlas-base-dev wget g++ build-essential python3-numpy python3-scipy
# python3-numpy python3-scipy
RUN python3 -m pip install --upgrade pip

#GET chewBBACA and Prodigal 
RUN git clone https://github.com/hyattpd/Prodigal.git
RUN git clone https://github.com/B-UMMI/chewBBACA.git
#INSTALL chewBBACA requirements 
WORKDIR /NGStools/chewBBACA
RUN pip3 install requirements.txt

WORKDIR /NGStools/Prodigal
RUN make install
WORKDIR /NGStools/

#install mafft and clustalw2 to run schema evaluator
RUN wget www.clustal.org/download/current/clustalw-2.1-linux-x86_64-libcppstatic.tar.gz
RUN tar -zxf clustalw-2.1-linux-x86_64-libcppstatic.tar.gz

#ADD chewBBACA TO PATH 
ENV PATH="/NGStools/chewBBACA:${PATH}"
ENV PATH="/NGStools/chewBBACA/utils/:$PATH"

# add clustalw2 to path
ENV PATH="/NGStools/clustalw-2.1-linux-x86_64-libcppstatic:${PATH}"
RUN which clustalw2
RUN which mafft