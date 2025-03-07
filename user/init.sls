guarantee user akshat-mahajan:
  user.present:
    - name: akshat-mahajan
    - home: /home/akshat-mahajan
    - groups: 
        - sudo
        - docker
        - root

allow passwordless sudo:
  file.append:
    - name: /etc/sudoers
    - text:
       - akshat-mahajan ALL=(ALL) NOPASSWD:ALL

generate ssh key if not exist:
  cmd.run:
    - name: ssh-keygen -t ed25519 -q -N '' -f /home/akshat-mahajan/.ssh/id_ed25519
    - runas: akshat-mahajan
    - unless: test -f /home/akshat-mahajan/.ssh/id_ed25519

generate ssh key if not exist for root:
  cmd.run:
    - name: ssh-keygen -t ed25519 -q -N '' -f /root/.ssh/id_ed25519
    - unless: test -f /root/.ssh/id_ed25519

install pyenv:
    cmd.run:
        - name: |
             curl https://pyenv.run | su akshat-mahajan -c bash  # installs pyenv for Python
        - unless: test -e /home/akshat-mahajan/.pyenv/bin/pyenv 
    grains.present:
        - name: installed_pyenv
        - value: true

install nvm:
    cmd.run:
        - name: | 
             curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | su akshat-mahajan -c bash  # NVM for Node.js
        - unless: test -e /home/akshat-mahajan/.nvm
    grains.present:
        - name: installed_nvm
        - value: true

create workspace directory for all projects:
  file.directory:
    - name: /home/akshat-mahajan/workspace
    - user: akshat-mahajan
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - user

set git email:
  git.config_set:
    - name: user.email
    - value: akshat-mahajanm.bkk@gmail.com
    - global: True
    - user: akshat-mahajan

set git username:
  git.config_set:
    - name: user.name
    - value: Akshat Mahajan
    - global: True
    - user: akshat-mahajan

set vim as core editor for my user:
  git.config_set:
    - name: core.editor
    - value: vim
    - global: True
    - user: akshat-mahajan
