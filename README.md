# RPi5-HailoAI.M2.Hat-install

Below I will show you the process of installing AI Hat for Raspberry Pi 5 with Ubuntu LTS Server operating system. AI Hat comes in 2 versions 13 TOPS and 26 TOPS, looking at the price and the difference of 2x in TOPS, it is rather more profitable to buy the 32 TOPS version. 
It is hard to find a ready script on the Internet that allows for easy and pleasant installation. Judging by experience, this process is very problematic and does not work as in the case of typing sudo apt install <package> in the console. 
If you are here then you most likely had the same problem as me. Writing one command generates another 10 errors.

### Documentation:
- Raspberry Pi 5 - https://www.raspberrypi.com/documentation/
- AI Hat - https://www.raspberrypi.com/documentation/accessories/ai-hat-plus.html
- Hailo Software - https://hailo.ai/developer-zone/documentation/
- Hailo Software Versions - https://hailo.ai/developer-zone/documentation/hailo-sw-suite-2025-01/?page=suite%2Fversions_compatibility.html#id1

### Attention !!! 
I recommend creating an account on [The Hailo AI](https://hailo.ai) website, because if any errors occur, the easiest way to find an answer is on the community page [Hailo Community](https://community.hailo.ai).

### Install Drivers (Firmware + PCIe)
I have prepared 3 scripts, the first one is for installing drivers for the firmware and for communication using PCIe.

sudo apt install git
sudo chmod +x ./config_hailo.sh
./firmware_and_PCIe.sh\
./test_firmware.sh
./hailo_install.sh
./TAPPAS_install.sh  #version python 3.11
./example_install.sh

Rest ERROR 