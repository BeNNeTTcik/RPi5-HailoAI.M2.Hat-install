#!/bin/bash

#read variables
if [ -f version.txt ]; then
    model_zoo=$(awk -F'=' '/^model_zoo=/{print $2}' version.txt)
    echo "Model_zoo: $model_zoo"
else
    echo "Sth wrong"
fi

#Main
cd $HOME/RPi5-HailoAI.M2.Hat-install-main
git clone https://github.com/hailo-ai/hailo_model_zoo.git --branch v${model_zoo//\"/}
cd hailo_model_zoo
cd pip install -e setup.py

