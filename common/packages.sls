git ppa:
    pkgrepo.managed:
        - ppa: git-core/ppa

install apt packages:
    pkg.installed:
        - refresh: true
        - pkgs:
            - git # favour git 2.0.0 and up, if possible
            - snapd # used for some services below
            - util-linux # used for `runuser`
            # netstat and ipconfig, etc.
            - net-tools
            - default-jre
            - vim
            # media player
            - vlc
            # visibility into system
            - nmon
            - sysstat
            # dependency for pyenv 
            - make 
            - build-essential 
            - libssl-dev 
            - zlib1g-dev 
            - libbz2-dev
            - libreadline-dev 
            - libsqlite3-dev 
            - wget
            - curl 
            - llvm
            - jq 
            - libncurses5-dev 
            - libncursesw5-dev 
            - xz-utils 
            - tk-dev 
            - libffi-dev 
            - liblzma-dev 
            - python-dev
            - python3-dev
            - imagemagick
            - python-openssl
            # static analysis tool for bash scripts
            - shellcheck
            - linux-tools-common 
            - linux-tools-generic 
            - linux-tools-{{ salt['cmd.run_stdout']('uname -r') }}

install vim plugin manager:
    cmd.run:
        - name: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        - unless: test -e ~/.vim/autoload/plug.vim

modify vim settings globally:
    file.append: 
        - name: /etc/vim/vimrc
        - text: 
            - set number

install google chrome:
    pkg.installed:
        - sources:
            - google-chrome-stable: https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        - unless: dpkg -l google-chrome-stable


install snapd packages:
    cmd.run:
        - name: |
             snap install sublime-text --classic  # Sublime Text 3
        - unless: snap list sublime-text

install protobuf package:
    cmd.run:
        - name: |
             snap install protobuf
        - unless: snap list protobuf

install kubectl:
    cmd.run:
        - name: |
             snap install kubectl
        - unless: snap list kubectl

install projectlibre packages:
    cmd.run:
        - name: |
             snap install projectlibre # OpenOffice tools!
        - unless: snap list projectlibre

install slack:
    cmd.run:
        - name: |
             snap install slack --classic
        - unless: snap list slack

install skype:
    cmd.run:
        - name: |
             snap install skype --classic 
        - unless: snap list skype

install packer:
    cmd.run:
        - name: |
            curl -LO https://raw.github.com/robertpeteuil/packer-installer/master/packer-install.sh
            chmod +x packer-install.sh
            ./packer-install.sh
        - unless: which packer
          
install tfswitch:
    cmd.run:
        - name: |
             curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash # Terraform version manager
        - unless: which tfswitch

# official instructions from docker.com
install docker:
    cmd.run:
        - name: |
            apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            apt-get update -y
            apt-get install -y docker-ce 
        - unless: docker

install helm:
    cmd.run: 
        - name: |
           curl https://helm.baltorepo.com/organization/signing.asc | sudo apt-key add -
           apt-get install apt-transport-https --yes
           echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
           apt-get update -y
           apt-get install -y helm

install docker-compose:
    cmd.run:
        - name: |
           sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
           sudo chmod +x /usr/local/bin/docker-compose

install blackbox:
    pkg.installed:
        - sources:
            - blackbox: salt://common/files/stack-blackbox_1.0-502_all.deb
