tryhy
=====

[Hy](http://hylang.org) repl running on [App Engine](https://developers.google.com/appengine/).

## hacking
```
git clone https://github.com/hylang/tryhy.git
pip install -r tryhy/requirements.txt -t tryhy/lib
pip install git+https://github.com/hylang/rply.git#egg=rply -t tryhy/lib
google_appengine/dev_appserver.py tryhy # run locally
google_appengine/appcfy.py --oauth2 tryhy -A <YOUR_APP_ID> # deploy
```
