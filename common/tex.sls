
install texlive with tlmgr:
    cmd.run:
        - name: |
            wget https://github.com/scottkosty/install-tl-ubuntu/raw/master/install-tl-ubuntu && chmod +x ./install-tl-ubuntu
            ./install-tl-ubuntu # this can take a LONG time!
            rm -rf install-tl-*
        - unless: which tlmgr

install texmaker:
    pkg.installed:
        - refresh: true
        - pkgs:
            - texmaker
