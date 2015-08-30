#!/bin/bash
echo root $1/eventDataBase\; > /etc/nginx/conf.d/doc_root.conf
cp -f /etc/nginx/config.php $1/eventDataBase/config/config.local.php
cp -f /etc/nginx/oauth2_local_sso_config.php $1/eventDataBase/dwbn-sso/lib/

service nginx reload
