#!/bin/bash

set -eu

COMETD_CFG_FILE=/var/lib/cometd/cometd.cfg

cometd::hook::config_validated() {
	# The config file (/var/lib/cometd/cometd.cfg) has been created and validated -
	# The Comet Server has not yet started, now is the time to enforce any config changes.
	echo "Applying startup config patches..." >&2

	backup_config

	jq '.StorageRole.RoleEnabled = false' $COMETD_CFG_FILE | sponge $COMETD_CFG_FILE
	jq '.ConstellationRole.RoleEnabled = true' $COMETD_CFG_FILE | sponge $COMETD_CFG_FILE

	return 0
}

# --

backup_config() {
	# Create a backup of the config file before patching - TODO: Add clean up?
	# Filename: cometd.cfg.bak-<unixtimestamp>[-<index>]
	CFG_FILE_BAK="$COMETD_CFG_FILE.bak-$(date +%s)"

	local i=0
	until [[ ! -f "$CFG_FILE_BAK" ]]; do
		CFG_FILE_BAK="$CFG_FILE_BAK-$i"
		(( i++ ))
	done

	cp -f $COMETD_CFG_FILE $CFG_FILE_BAK
}
