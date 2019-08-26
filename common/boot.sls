disable bluetoothd on boot because I do not use it:
    service.disabled:
        - name: bluetooth

disable docker on boot for faster startup time:
    service.disabled:
        - name: docker

disable salt-minion on boot for faster startup time:
    service.disabled:
        - name: salt-minion

disable snapd on boot for faster startup time:
    service.disabled:
        - name: snapd
