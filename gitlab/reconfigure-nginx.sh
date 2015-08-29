#!/bin/bash
echo root $1/web\; > /etc/nginx/conf.d/doc_root.conf
service nginx reload
