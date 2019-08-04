git ppa:
    pkgrepo.managed:
        - ppa: git-core/ppa

install apt packages:
    pkg.installed:
        - refresh: true
        - pkgs:
            - texlive-full # base LaTeX installation, all packages included 
            - texmaker # preferred LaTeX editor
            - git # favour git 2.0.0 and up, if possible
            - snapd # used for some services below

install more apt packages:
    pkg.installed:
        - sources:
            # Chrome browser  
            - google-chrome-stable: https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            - bat: https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb 

install snapd packages:
    cmd.run:
        - name: |
             snap install sublime-text --classic  # Sublime Text 3
             snap install projectlibre # OpenOffice tools!
             snap install slack --classic # Slack
             snap install skype --classic

install language managers:
    cmd.run:
        - name: |
             curl https://pyenv.run | bash  # installs pyenv for Python
             curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash  # NVM for Node.js
             curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash # Terraform version manager

# installs Golang version manager from https://github.com/moovweb/gvm
install gvm:
    cmd.run:
        - name: |
            apt-get install mercurial make binutils bison gcc build-essential
            bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) # Golang - installs gvm

# official instructions from docker.com
install docker:
    cmd.run:
        - name: |
            apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            apt-get update
            apt-get install docker-ce docker-ce-cli containerd.io
        - unless: which docker
