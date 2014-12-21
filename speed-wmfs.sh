#!/bin/bash

RXB=$(cat /sys/class/net/eno1/statistics/rx_bytes)
TXB=$(cat /sys/class/net/eno1/statistics/tx_bytes)
sleep 2 
RXBN=$(cat /sys/class/net/eno1/statistics/rx_bytes)
TXBN=$(cat /sys/class/net/eno1/statistics/tx_bytes)
RXDIF=$(echo $((RXBN - RXB)) )
TXDIF=$(echo $((TXBN - TXB)) )

echo "$((TXDIF / 1024 / 2))k/s $((RXDIF / 1024 / 2))k/s"
