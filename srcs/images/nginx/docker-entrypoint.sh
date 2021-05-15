#!/bin/sh

nginx -t -v
nginx -g "daemon off;" $@
