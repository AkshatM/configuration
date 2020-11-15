{% if not grains.get("installed_starship") %}
install nerdfonts for starship:
    archive.extracted:
        - name: /home/akshat/.fonts/Ubuntu
        - source: salt://user/files/Ubuntu.zip
    cmd.run:
        - name: fc-cache -fv

install starship:
    cmd.run:
        - name: curl -fsSL https://starship.rs/install.sh --force | bash
        - unless: which starship 
    grains.present:
        - name: installed_starship
        - value: true
{% endif %}

update starship configuration:
  file.managed:
    - name: /home/akshat/.config/starship.toml
    - source: salt://user/files/starship.toml
    - user: akshat
    - mode: 644


modify .bashrc:
  file.managed:
    - name: /home/akshat/.bashrc
    - source: salt://user/files/.bashrc
    - template: jinja

modify .profile:
  file.managed:
    - name: /home/akshat/.profile
    - source: salt://user/files/.profile
    - template: jinja


create nav script:
  file.managed:
    - name: /usr/bin/navigate
    - source: salt://user/files/navigate
    - template: jinja
    - user: akshat
    - mode: 755 
  grains.present:
    - name: custom_navigation
    - value: true

{% if not grains.get("installed_g") %}
# installs g (https://github.com/stefanmaric/g), a Golang version manager
# needs to be installed here as it modifies .bashrc for us, so we have to be careful
install g:
    cmd.run:
        - name: curl -sSL https://git.io/g-install | bash -s -- -y
        - env:
          - GOPATH: '/home/akshat/workspace/go'
        - unless: test -e /home/akshat/workspace/go/bin/g
    grains.present:
        - name: installed_g
        - value: true
{% endif %}

{% if not grains.get("sublime_text_configured") %}
add sublime-text settings:
  file.recurse:
    - name: /home/akshat/.config/sublime-text-3/Packages/User
    - source: salt://user/files/sublime-text-settings
    - user: akshat
  grains.present:
    - name: sublime_text_configured
    - value: true
{% endif %}
