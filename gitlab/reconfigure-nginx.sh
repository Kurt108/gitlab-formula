#!/bin/bash
echo root $PWD/web; > /etc/nginx/conf.d/doc_root.conf
service nginx reload
