#!/bin/bash

##############
# Waiting for install to finish
##############

while [ ! -f /tmp/finished ]; do sleep 1; done

# Installation complete...