#!/bin/bash

sudo /usr/sbin/varnishd -a :6081 -f /etc/varnish/default.vcl -s malloc,256m
