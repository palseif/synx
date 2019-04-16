#!/bin/bash
# shellcheck disable=SC2034

# Copyright (c) 2018
# All rights reserved.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

# Run this file
# bash -i <(wget -4qO- -o- https://gist.githubusercontent.com/mikeytown2/5c72c1ded740d210146c550faaf76eb7/raw/syndicated.sh) ; source ~/.bashrc
# bash -ic "$(wget -4qO- -o- goo.gl/ncErX1)" ; source ~/.bashrc

# Directory
DIRECTORY='.syndicate'
# Port
DEFAULT_PORT=25992
# Conf File
CONF='syndicate.conf'
# Display Name
DAEMON_NAME='syndicate'
# Github user and project.
GITHUB_REPO='SyndicateLtd/SyndicateQt'
# Binary base name.
BIN_BASE='syndicate'
# Direct Daemon Download if github has no releases.
DAEMON_DOWNLOAD=''
# Username Prefix
DAEMON_PREFIX='synx_mn'
# RPC username
RPC_USERNAME='syndicate'
# Explorer URL
EXPLORER_URL='http://explorer.synx.online//'
# Log filename
DAEMON_SETUP_LOG='/tmp/syndicate.log'
# Masternode output file.
DAEMON_SETUP_INFO="${HOME}/syndicate.mn.txt"
# Project Folder
PROJECT_DIR='syndicate'
# Amount of Collateral needed
COLLATERAL=5000
# Coin Ticker
TICKER='synx'
# Tip Address
TIPS='VKizdNCrnAfKHFv3sEfxxCDZ3gzf35LsNW'
# Dropbox Addnodes
DROPBOX_ADDNODES='xbyfnujljh6apdg'
# If set to 1 then use addnodes from dropbox.
USE_DROPBOX_ADDNODES=0
# Dropbox Bootstrap
DROPBOX_BOOTSTRAP='kenhhybzx8iqaxv'
# If set to 1 then use bootstrap from dropbox.
USE_DROPBOX_BOOTSTRAP=0
# Dropbox blocks and chainstake folders.
DROPBOX_BLOCKS_N_CHAINS='6mf5i7gow8blbhw'
# Cycle Daemon
DAEMON_CYCLE=0
# Fallback Blockcount
BLOCKCOUNT_FALLBACK_VALUE=140000
# Slow Daemon Start.
SLOW_DAEMON_START=0
# Bad Explorer SSL.
BAD_SSL_HACK=''
# Extra configuation for the conf file.
EXTRA_CONFIG=''
# Auto Recovery.
RESTART_IN_SYNC=1
# Multiple on single IP.
MULTI_IP_MODE=1
# Number of Connections to wait for.
DAEMON_CONNECTIONS=6
# Wait for MNSYNC
#MNSYNC_WAIT_FOR='"RequestedMasternodeAssets": 999,'
MNSYNC_WAIT_FOR=''
# Run Mini Monitor.
MINI_MONITOR_RUN=1
# Mini Monitor check masternode list.
MINI_MONITOR_MN_LIST=1
# Mini Monitor Status to check for.
MINI_MONITOR_MN_STATUS='4'
# Mini Monitor Queue Payouts.
MINI_MONITOR_MN_QUEUE=1
# Mini Monitor masternode count is a json string.
MINI_MONITOR_MN_COUNT_JSON=1

# Log to a file.
rm -f "${DAEMON_SETUP_LOG}"
touch "${DAEMON_SETUP_LOG}"
chmod 600 "${DAEMON_SETUP_LOG}"
exec >  >(tee -ia "${DAEMON_SETUP_LOG}")
exec 2> >(tee -ia "${DAEMON_SETUP_LOG}" >&2)


ASCII_ART () {
echo -e "\\e[0m"
clear 2> /dev/null
cat << "syndicate"

_/\\________/\\__/\\\\\\\\\\\\__/\\\\_____/\\_______/\\\\_______/\\_______/\\
_\/\\_______\/\\_\/\\/////////__\/\\\\\___\/\\_____/\\///\\_____\//\\___/\\/
 _\//\\______/\\__\/\\___________\/\\/\\\__\/\\___/\\/___\//\\____\//\\\\/
  __\//\\____/\\___\/\\\\\\\\\____\/\\//\\\_\/\\__/\\______\//\\____\//\\\
   ___\//\\__/\\____\/\\//////_____\/\\\//\\\\/\\_\/\\_______\/\\_____\/\\
    ____\//\\/\\_____\/\\___________\/\\_\//\\\/\\_\//\\______/\\____/\\\\\
     _____\//\\\______\/\\___________\/\\__\//\\\\\__\//\\___/\\____/\\///\\\
      _____\//\\_______\/\\\\\\\\\\\\_\/\\___\//\\\\____\//\\\/____/\\/__\//\\
       ______\//________\////////////__\//_____\////______\///_____\//_____\//

syndicate
}

SENTINEL_SETUP () {
  echo
}

# Discord User Info
# @mcarper#0918
# 401161988744544258
cd ~/ || exit
COUNTER=0
rm -f ~/___mn.sh
while [[ ! -f ~/___mn.sh ]] || [[ $( grep -Fxc "# End of masternode setup script." ~/___mn.sh ) -eq 0 ]]
do
  rm -f ~/___mn.sh
  echo "Downloading Masternode Setup Script."
  wget -4qo- goo.gl/uQw9tz -O ~/___mn.sh
  COUNTER=$((COUNTER+1))
  if [[ "${COUNTER}" -gt 3 ]]
  then
    echo
    echo "Download of masternode setup script failed."
    echo
    exit 1
  fi
done

(
  sleep 2
  rm ~/___mn.sh
) & disown

# shellcheck disable=SC1091
# shellcheck source=/root/___mn.sh
. ~/___mn.sh
DAEMON_SETUP_THREAD
# shellcheck source=/root/.bashrc
. ~/.bashrc
stty sane
