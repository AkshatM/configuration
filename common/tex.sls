
{% if not grains.get("installed_texlive") %}
install texlive with tlmgr:
    cmd.run:
        - name: |
            mkdir -p install-tl
            wget -P install-tl https://github.com/scottkosty/install-tl-ubuntu/raw/master/install-tl-ubuntu && chmod +x ./install-tl/install-tl-ubuntu
            ./install-tl/install-tl-ubuntu # this can take a LONG time!
            rm -rf install-tl
    grains.present:
        - name: installed_texlive
        - value: true
{% endif %}


install texmaker:
    pkg.installed:
        - refresh: true
        - pkgs:
            - texmaker
