#!/bin/bash

# Variables
host="127.0.0.1"
url="http://${host}/index.php?check-msg"
timeout=200  # timeout for curl request in seconds
user_agent='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 PizzaOS/OnvioCTF{E3n_l3kker_K03k1e_4s_D3ss3rt}(1v.1) Chrome/37.0.2062.120 Safari/537.36'

# Add cookie
cookie="FLAG2?=Helaas is niet beschikbaar; Domain=${host}; HttpOnly;"

# Function to handle the timeout
handle_timeout() {
    echo "[INFO] Timeout"
    exit 1
}

# Set a trap to handle script timeout
trap 'handle_timeout' SIGALRM

# Start a timer for the timeout
( sleep $timeout && kill -s SIGALRM $$ ) &

# Make the HTTP request
response=$(curl -s -m $timeout --cookie "$cookie" -A "$user_agent" "$url")

# Check the response status
if [ $? -ne 0 ]; then
    echo "[INFO] Error or timeout occurred"
    exit 1
else
    echo "[INFO] rendered page"
    echo "$response"  # Optionally print the response
fi

# Properly exit the script
exit 0
