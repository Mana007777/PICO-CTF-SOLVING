#!/bin/bash

HOST="verbal-sleep.picoctf.net"
PORT=52243

{
sleep 1
echo "password123"
sleep 1
echo "letmein"
sleep 1
echo "qwerty098"
} | nc $HOST $PORT
