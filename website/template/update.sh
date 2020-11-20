#!/bin/bash

apt update && apt upgrade
rm -rf /var/lib/apt/lists/*
apt clean