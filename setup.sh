#!/bin/bash

# Update and upgrade the system
sudo apt-get update -y && sudo apt-get upgrade -y

# Install necessary packages
sudo apt-get install -y python3 python3-pip python3-venv
sudo apt-get install -y portaudio19-dev libsndfile1 ffmpeg

# Create a virtual environment
python3 -m venv whisper_env
source whisper_env/bin/activate

# Install whisper-live
pip install whisper-live

# Install PyAudio (note: this step may require additional handling for different systems)
pip install pyaudio

# Confirm installations
echo "Python version:"
python --version
echo "Pip version:"
pip --version
echo "FFmpeg version:"
ffmpeg -version

echo "Setup complete. To start the server, run:"
echo "source whisper_env/bin/activate"
echo "python3 run_server.py --port 9090 --backend faster_whisper"
