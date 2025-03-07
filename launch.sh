#/bin/bash

set -x

# This translates to the directory this bash script is in.
FILE_ROOT="$(dirname $(realpath $0))"

# install curl - this is my standard tool, so I'd prefer having it 
install_curl() {
	apt-get install -y curl
}

# base installation of Salt - will gladly reinstall Salt for us.
install_salt() {
	# Ensure keyrings dir exists
	mkdir -p /etc/apt/keyrings
	# Download public key
	curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
	# Create apt repo target configuration
	curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
	apt-get install -y salt-minion
}

# overwrites the default salt config with our preferences
modify_salt_config() {
	sudo bash -c "cat > /etc/salt/minion" <<-EOF
	renderer: jinja|yaml 
	file_client: local
	file_roots:
	    base:
	        - ${FILE_ROOT}
	EOF
}

apply_salt_highstate() {
	# install packages here as salt hates me
	apt-get install -y git-all snapd gnome-tweaks util-linux \
		clamav clamav-daemon htop net-tools default-jre vim vlc nmon jq curl \
		imagemagick python3-dev linux-tools-common linux-tools-generic shellcheck bat dbus-x11
	sudo -E salt-call state.apply -l debug
}

main() {
	# only install Salt if it is not already installed
	which salt-call || { install_salt && modify_salt_config; }
	# always run a highstate
	apply_salt_highstate
	git remote set-url origin git@github.com:AkshatM/configuration.git
}

main
