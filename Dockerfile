from ubuntu
RUN apt-get update \
# install tools: git, linux-tools-generic, python, pip
    && apt-get install -y git linux-tools-generic python python-pip zip \
    && rm -f /usr/bin/perf && ln -s /usr/lib/linux-tools/4.4.0-116-generic/perf /usr/bin/perf \
# git clone project and config path
    && cd ~ \
    && git clone https://github.com/andikleen/pmu-tools.git \
    && git clone https://github.com/davidsandberg/facenet.git \
    && git clone https://github.com/katrina95/cmpe202_Computer_Architecture.git \
    && echo "export PATH=~/pmu-tools:$PATH" >> ~/.bashrc \
# download dependencies: tqdm, python2.7, Python 3.n, tensorflow, librosa
    && apt-get install python-pip python-dev \
    && apt-get install python3-pip python3-dev \
    && pip install tensorflow \
    && pip install -r ./facenet/requirements.txt \
# get the dataset and pre-trained model
    && cd ~/cmpe202_Computer_Architecture
    && cat model* > 20170512-110547 \
    && cat lfw* > lfw \
    && rm model* \
    && rm lfw* \
    && mkdir ~/datasets \
    && cd ~/datasets \
    && mkdir -p lfw/raw \
    && tar xvf ~/cmpe202_Computer_Architecture/lfw -C ~/datasets/lfw/raw --strip-components=1 \
    && export PYTHONPATH=~/facenet/src \
    && pip install scipy \
    && apt-get install python-scipy \
    && apt-get install python-opencv \
    && for N in {1..4}; do python ~/facenet/src/align/align_dataset_mtcnn.py ~/datasets/lfw/raw ~/datasets/lfw/lfw_mtcnnpy_160 --image_size 160 --margin 32 --random_order --gpu_memory_fraction 0.25 & done \
    && mkdir ~/models \
    && cd ~ \
    && apt-get install unzip \
    && unzip ~/cmpe202_Computer_Architecture/20170512-110547 -d ~/models
    && tar xvf ~/cmpe202_Computer_Architecture/20170512-110547 -C ~/models --strip-components=1 \
    && cd ~/facenet \
    && python ~/facenet/src/validate_on_lfw.py ~/datasets/lfw/lfw_mtcnnpy_160 ~/models/20170512-110547 \
    
    
docker build -t ubuntu:wenting
