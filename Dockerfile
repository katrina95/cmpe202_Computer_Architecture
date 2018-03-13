from ubuntu
RUN apt-get update \
# install tools: git, linux-tools-generic, python, pip
    && apt-get install -y git linux-tools-generic python python-pip zip \
    && rm -f /usr/bin/perf && ln -s /usr/lib/linux-tools/4.4.0-116-generic/perf /usr/bin/perf \
# git clone project and config path
    && cd ~ \
    && git clone https://github.com/andikleen/pmu-tools.git \
    && git clone https://github.com/davidsandberg/facenet.git \
    && git clone https://github.com/davidsandberg/facenet.git \
    && echo "export PATH=~/pmu-tools:$PATH" >> ~/.bashrc \
# download dependencies: tqdm, python2.7, Python 3.n, tensorflow, librosa
    && apt-get install python-pip python-dev \
    && apt-get install python3-pip python3-dev \
    && pip install tensorflow \
    && pip install -r ./facenet/requirements.txt \
# get the dataset and pre-trained model
    &&cat modelaa modelab modelac modelad modelae modelaf modelag modelah > 20170512-110547.zip model
    &&cat modelaa lfwaa lfwab lfwac lfwad lfwae lfwaf lfwag lfwah > lfw.tgz
    
    
docker build -t ubuntu:wenting
