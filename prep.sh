#!/bin/bash

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt clean
sudo apt install -y build-essential htop python-dev cmake git python-pip 
