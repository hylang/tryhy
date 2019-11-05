tryhy
=====

[Hy](http://hylang.org) repl running on [App Engine](https://developers.google.com/appengine/).

## hacking
```
git clone https://github.com/hylang/tryhy.git
cd tryhy
python3 -m venv env
env/bin/python -m pip install setuptools pip wheel --upgrade
env/bin/python -m pip install -r requirements.txt
# try locally
FLASK_APP=main.py SERVER_SOFTWARE=dev env/bin/flask run
# deploy
gcloud app deploy --no-promote --project try-hy --version $(git rev-parse --short HEAD) .
```
