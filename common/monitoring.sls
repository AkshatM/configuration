install collectd:
    pkg.installed:
        - refresh: True
        - pkgs:
            - collectd

modify collectd configuration:
    file.managed:
        - name: /etc/collectd/collectd.conf
        - source: salt://common/files/collectd.conf
        - template: jinja
        - onlyif: test -e /etc/collectd/collectd.conf

ensure collectd is running:
    service.running:
        - name: collectd
        - watch: 
            - file: /etc/collectd/collectd.conf
 
