from ubuntu
RUN apt-get update \
# install tools: git, linux-tools-generic, python, pip
    && apt-get install -y git linux-tools-generic python python-pip zip \
    && rm -f /usr/bin/perf && ln -s /usr/lib/linux-tools/4.4.0-116-generic/perf /usr/bin/perf \
# git clone project and config path
    && cd ~ \
    && git clone https://github.com/andikleen/pmu-tools.git \
    && git clone https://github.com/andabi/deep-voice-conversion.git \
    && echo "export PATH=~/pmu-tools:$PATH" >> ~/.bashrc \
# download dependencies: tqdm, python2.7, Python 3.n, tensorflow, librosa
    && pip install -e git+https://github.com/tqdm/tqdm.git@master#egg=tqdm
    && apt-get install python-pip python-dev
    && apt-get install python3-pip python3-dev
    && pip install tensorflow
    && pip install librosa
# train the model 
    && python ./deep-voice-conversion/train1.py default
    && python ./deep-voice-conversion/eval1.py default
    && python ./deep-voice-conversion/convert.py default
    
