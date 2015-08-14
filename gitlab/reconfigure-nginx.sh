#!/bin/bash
echo root $CWD/web; > /etc/nginx/conf.d/doc_root.conf
service nginx reload
