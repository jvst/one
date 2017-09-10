#!/bin/sh

#msgqueue configuration
sysctl -w kernel.msgmax=65535
sysctl -w kernel.msgmnb=6553500
ipcs -ql
