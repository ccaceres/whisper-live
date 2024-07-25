#!/bin/bash

# Update and upgrade the system
apt-get update -y && apt-get upgrade -y

# Install necessary packages
apt-get install -y python3 python3-pip python3-venv git
apt-get install -y portaudio19-dev libsndfile1 ffmpeg

# Create swap file to handle memory issues
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

# Clone the Whisper Live repository if it doesn't exist
if [ ! -d "whisper-live" ]; then
  git clone https://github.com/collabora/WhisperLive.git whisper-live
fi

cd whisper-live

# Create a virtual environment
python3 -m venv whisper_env
source whisper_env/bin/activate

# Install whisper-live
pip install whisper-live

# Install PyTorch with retry logic
for i in {1..3}; do
  pip install torch torchvision torchaudio && break
  echo "Retrying PyTorch installation ($i)..."
  sleep 5
done

# Install PyAudio
pip install pyaudio

# Confirm installations
echo "Python version:"
python3 --version
echo "Pip version:"
pip --version
echo "FFmpeg version:"
ffmpeg -version

# Start the Whisper Live server
echo "Starting the Whisper Live server..."
nohup python3 run_server.py --port 9090 --backend faster_whisper &

# Wait for a few seconds to ensure the server starts
sleep 10

# Display message indicating the server has started
echo "Whisper Live server is running on port 9090."
