always display battery percentage in gnome:
    cmd.run:
        - name: gsettings set org.gnome.desktop.interface show-battery-percentage true
        - unless: test -e $(which gsettings) 
