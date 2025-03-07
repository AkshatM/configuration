install rust:
    cmd.run:
        - name: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | su akshat-mahajan -c 'sh -s -- -y'
        - unless: which cargo
    grains.present:
        - name: installed_rust
        - value: true 

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

# installing snap packages in Docker is painfully slow and thus avoided
{% if not salt['environ.get']('TEST') %}

install kubectl:
    cmd.run:
        - name: |
             snap install kubectl --classic
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

install VS code:
    cmd.run:
        - name: |
             snap install code --classic
        - unless: snap list code
{% endif %}

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
install docker and docker-compose:
    cmd.run:
        - name: |
                sudo apt-get install -y ca-certificates curl
                sudo install -m 0755 -d /etc/apt/keyrings
                sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
                sudo chmod a+r /etc/apt/keyrings/docker.asc
                echo \
                     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                     $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
                     sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update -y
                apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        - unless: docker

install helm:
    cmd.run: 
        - name: |
           curl https://helm.baltorepo.com/organization/signing.asc | sudo apt-key add -
           apt-get install apt-transport-https --yes
           echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
           apt-get update -y
           apt-get install -y helm

install ollama:
    cmd.run:
        - name: curl -fsSL https://ollama.com/install.sh | su akshat-mahajan -c 'sh -s -- -y'
        - unless: which ollama
