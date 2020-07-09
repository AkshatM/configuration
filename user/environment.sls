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
