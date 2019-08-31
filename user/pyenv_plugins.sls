add pyenv virtualenv:
    git.cloned:
        - name: https://github.com/pyenv/pyenv-virtualenv.git 
        - target: /home/akshat/.pyenv/plugins/pyenv-virtualenv
        - user: akshat
    grains.present:
        - name: installed_pyenv_virtualenv
        - value: true
