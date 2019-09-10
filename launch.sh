#/bin/bash

set -x

SALT_VERSION='v2019.2.0'

# This translates to the directory this bash script is in.
FILE_ROOT="$(dirname $(realpath $0))"

# install curl - this is my standard tool, so I'd prefer having it 
install_curl() {
	apt-get install -y curl
}

# base installation of Salt - will gladly reinstall Salt for us.
install_salt() {
        which curl || install_curl
	curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh && sudo sh bootstrap_salt.sh git ${SALT_VERSION}
	rm bootstrap_salt.sh
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
	sudo salt-call state.apply -l debug
}

main() {
	# only install Salt if it is not already installed
	which salt-call || { install_salt && modify_salt_config; }
	# always run a highstate
	apply_salt_highstate
	git remote set-url origin git@github.com:AkshatM/configuration.git
}

main
