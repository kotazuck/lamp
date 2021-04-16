#!/bin/sh

mysqld --daemonize

apache2ctl -D FOREGROUND
