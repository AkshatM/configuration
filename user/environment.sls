{% if not grains.get("installed_starship") %}
install starship:
    cmd.run:
        - name: curl -fsSL https://starship.rs/install.sh | sh -s -- -y
        - unless: which starship 
    grains.present:
        - name: installed_starship
        - value: true
{% endif %}

update starship configuration:
  file.managed:
    - name: /home/akshat-mahajan/.config/starship.toml
    - source: salt://user/files/starship.toml
    - user: akshat-mahajan
    - mode: 644


modify .bashrc:
  file.managed:
    - name: /home/akshat-mahajan/.bashrc
    - source: salt://user/files/.bashrc
    - template: jinja

modify .profile:
  file.managed:
    - name: /home/akshat-mahajan/.profile
    - source: salt://user/files/.profile
    - template: jinja


create nav script:
  file.managed:
    - name: /usr/bin/navigate
    - source: salt://user/files/navigate
    - template: jinja
    - user: akshat-mahajan
    - mode: 755 
  grains.present:
    - name: custom_navigation
    - value: true

{% if not grains.get("installed_g") %}
# installs g (https://github.com/stefanmaric/g), a Golang version manager
# needs to be installed here as it modifies .bashrc for us, so we have to be careful
install g:
    cmd.run:
        - name: curl -sSL https://git.io/g-install | su akshat-mahajan -c 'bash -s --y'
        - env:
          - GOPATH: '/home/akshat-mahajan/go'
        - unless: test -e /home/akshat-mahajan/go/bin/g
    grains.present:
        - name: installed_g
        - value: true
{% endif %}
