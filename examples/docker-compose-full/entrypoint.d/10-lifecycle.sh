#!/bin/bash

set -eu

cometd::hook::on_start() {
	# The Comet Server is about to start up - do any preflight checks here
	return 0
}

cometd::hook::on_failure() {
	# The Comet Server is about has encountered an unexpected error and restarted -
	# Log this event, or send a slack notification, etc.
	#
	# @see https://api.slack.com/tutorials/tracks/posting-messages-with-curl
	#	curl -X POST \
	#		-d "text=Your Comet Server had an unexpected error and restarted!" \
	#		-d "channel=C123456" \
	#		-H "Authorization: Bearer xoxb-not-a-real-token-this-will-not-work" \
	#		https://slack.com/api/chat.postMessage
	return 0
}