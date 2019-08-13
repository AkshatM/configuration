always display battery percentage in gnome:
    cmd.run:
        - name: gsettings set org.gnome.desktop.interface show-battery-percentage true

always display date and time in top bar:
    cmd.run:
        - name: gsettings set org.gnome.desktop.interface clock-show-date true
