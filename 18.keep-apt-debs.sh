#!/bin/bash

# keep old APT debs

echo 'APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/01keep-debs
