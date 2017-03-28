#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Configure root password
# -----------------------------------------------------------------------------
echo "root:${ROOT_PASSWORD:-$DEFAULT_PASSWORD}" | chpasswd

# -----------------------------------------------------------------------------
# Configure ShadowsocksR
# -----------------------------------------------------------------------------
sed -i \
	-e 's/"server_port".*/"server_port": '$SSR_PORT',/' \
	-e 's/"password".*/"password": "'${SSR_PASSWORD:-$DEFAULT_PASSWORD}'",/' \
	-e 's/"method".*/"method": "'${SSR_METHOD:-aes-256-cfb}'",/' \
	-e 's/"protocol".*/"protocol": "'${SSR_PROTOCOL:-origin}'",/' \
	-e 's/"obfs".*/"obfs": "'${SSR_OBFS:-plain}'",/' \
	/root/shadowsocksr/shadowsocks/user-config.json
	
# -----------------------------------------------------------------------------
# Configure supervisor
# -----------------------------------------------------------------------------
sed -i \
	-e 's/port=.*/port='$SVD_PORT'/' \
	-e 's/username=.*/username='${SVD_USERNAME:-$DEFAULT_USERNAME}'/' \
	-e 's/password=.*/password='${SVD_PASSWORD:-$DEFAULT_PASSWORD}'/' \
	/etc/supervisord.conf
	
