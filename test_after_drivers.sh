#!/bin/bash
if(ls /dev/hailo*); then
    echo "Hailo device is detected under /dev folder"
    ls /dev/hailo*
else
    echo "Hailo device is not detected, something went wrong"
fi


