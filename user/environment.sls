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

