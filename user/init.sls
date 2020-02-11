guarantee user akshat:
  user.present:
    - name: akshat
    - home: /home/akshat
    - groups: 
        - sudo
        - docker
        - root

allow passwordless sudo:
  file.append:
    - name: /etc/sudoers
    - text:
       - akshat ALL=(ALL) NOPASSWD:ALL

generate ssh key if not exist:
  cmd.run:
    - name: ssh-keygen -q -N '' -f /home/akshat/.ssh/id_rsa
    - runas: akshat
    - unless: test -f /home/akshat/.ssh/id_rsa

generate ssh key if not exist for root:
  cmd.run:
    - name: ssh-keygen -q -N '' -f /root/.ssh/id_rsa
    - unless: test -f /root/.ssh/id_rsa

install pyenv:
    cmd.run:
        - name: |
             curl https://pyenv.run | bash  # installs pyenv for Python
        - unless: test -e /home/akshat/.pyenv/bin/pyenv 
    grains.present:
        - name: installed_pyenv
        - value: true

install nvm:
    cmd.run:
        - name: | 
             curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash  # NVM for Node.js
        - unless: test -e /home/akshat/.nvm
    grains.present:
        - name: installed_nvm
        - value: true

# installs Golang version manager from https://github.com/moovweb/gvm
install gvm:
    cmd.run:
        - name: |
            apt-get install mercurial make binutils bison gcc build-essential
            bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) # Golang - installs gvm
        - unless: test -e /home/akshat/.gvm/bin/gvm
    grains.present:
        - name: installed_gvm
        - value: true

install bat:
    pkg.installed:
        - sources:
            - bat: https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb
        - unless: dpkg -l bat
    grains.present:
        - name: installed_bat
        - value: true

create workspace directory for all projects:
  file.directory:
    - name: /home/akshat/workspace
    - user: akshat
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - user

create go directory for all Golang projects:
  file.directory:
    - name: /home/akshat/workspace/go
    - user: akshat
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - user

{% for directory in ['pkg', 'src', 'bin'] %}
create go/{{ directory }} directory for all Golang projects:
  file.directory:
    - name: /home/akshat/workspace/go/{{ directory }}
    - user: akshat
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - user
{% endfor %}

set git email:
  git.config_set:
    - name: user.email
    - value: akshatm.bkk@gmail.com
    - global: True
    - user: akshat

set git username:
  git.config_set:
    - name: user.name
    - value: Akshat Mahajan
    - global: True
    - user: akshat

set vim as core editor for my user:
  git.config_set:
    - name: core.editor
    - value: vim
    - global: True
    - user: akshat
