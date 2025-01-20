#!/bin/bash

# Skrip untuk mengunduh dan menginstal t3rn executor

# Set nama direktori
DIRECTORY="t3rn"

echo "=== Membuat direktori $DIRECTORY ==="
mkdir -p $DIRECTORY
cd $DIRECTORY || { echo "Gagal masuk ke direktori $DIRECTORY"; exit 1; }

echo "=== Mengunduh rilis terbaru ==="
TAG=$(curl -s https://api.github.com/repos/t3rn/executor-release/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
if [ -z "$TAG" ]; then
  echo "Gagal mendapatkan tag rilis terbaru."
  exit 1
fi

FILE_NAME="executor-linux-$TAG.tar.gz"
URL="https://github.com/t3rn/executor-release/releases/download/$TAG/$FILE_NAME"

echo "Mengunduh file dari $URL..."
wget $URL -O $FILE_NAME
if [ $? -ne 0 ]; then
  echo "Gagal mengunduh file dari $URL"
  exit 1
fi

echo "=== Mengekstrak arsip $FILE_NAME ==="
tar -xzf $FILE_NAME
if [ $? -ne 0 ]; then
  echo "Gagal mengekstrak file $FILE_NAME"
  exit 1
fi

echo "=== Masuk ke direktori binary ==="
cd executor/executor/bin || { echo "Gagal masuk ke direktori executor/executor/bin"; exit 1; }

echo "Skrip selesai! Anda berada di $(pwd)"
echo "Untuk menjalankan executor, gunakan perintah: ./executor"
