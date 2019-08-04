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
            - util-linux # used for `runuser`

install google chrome:
    pkg.installed:
        - sources:
            - google-chrome-stable: https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        - unless: dpkg -l google-chrome-stable

install bat:
    pkg.installed:
        - sources:
            - bat: https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb 
        - unless: dpkg -l bat

install snapd packages:
    cmd.run:
        - name: |
             snap install sublime-text --classic  # Sublime Text 3
             snap install projectlibre # OpenOffice tools!
             snap install slack --classic # Slack
             snap install skype --classic
          
install tfswitch:
    cmd.run:
        - name: |
             curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash # Terraform version manager
        - unless: which tfswitch

# official instructions from docker.com
install docker:
    cmd.run:
        - name: |
            apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            apt-get update
            apt-get install docker-ce docker-ce-cli containerd.io
        - unless: docker
