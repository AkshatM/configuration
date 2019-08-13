guarantee user akshat:
  user.present:
    - name: akshat
    - home: /home/akshat
    - groups: 
        - sudo
        - docker

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

install pyenv:
    cmd.run:
        - name: |
             curl https://pyenv.run | bash  # installs pyenv for Python
        - unless: test -e /home/akshat/.pyenv/bin/pyenv 

install nvm:
    cmd.run:
        - name: | 
             curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash  # NVM for Node.js
        - unless: test -e /home/akshat/.nvm

# installs Golang version manager from https://github.com/moovweb/gvm
install gvm:
    cmd.run:
        - name: |
            apt-get install mercurial make binutils bison gcc build-essential
            bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) # Golang - installs gvm
        - unless: test -e /home/akshat/.gvm/bin/gvm

modify bashrc:
  file.append:
    - name: /home/akshat/.bashrc
    - text:
       - alias cat="bat"
       - export PYENV_ROOT="$HOME/.pyenv"
       - export PATH="$PYENV_ROOT/bin:$PATH"
