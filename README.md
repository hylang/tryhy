tryhy
=====

[Hy](http://hylang.org) repl running on [App Engine](https://developers.google.com/appengine/).

## hacking
```
git clone https://github.com/hylang/tryhy.git
pip install -r tryhy/requirements.txt -t tryhy/lib
google_appengine/dev_appserver.py tryhy # run locally
gcloud app deploy tryhy/app.yaml
```
