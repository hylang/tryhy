(import os
        json
        sys
        [io [StringIO]]
        [hy.cmdline [HyREPL]]
        hy
        [flask [Flask redirect request render-template-string]])

(setv index-template #[[<!DOCTYPE html>
<html>
  <head>
    <title>try-hylang</title>
    <meta name="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="{{ url_for('static', filename='jquery-1.4.2.min.js') }}"></script>
    <script type="text/javascript" src="{{ url_for('static', filename='jquery.console.js') }}"></script>
    <script type="text/javascript" src="{{ url_for('static', filename='repl.js') }}"></script>
    <script type="text/javascript">
      var hy_version = '{{hy_version}}';
      var server_software = '{{server_software}}';
    </script>
    <link rel="stylesheet" type="text/css" href="{{ url_for('static', filename='style.css') }}">
    <meta property="og:title" content="try-hylang" />
    <meta property="og:image" content="http://docs.hylang.org/en/latest/_images/hy_logo-smaller.png" />
    <meta property="og:description" content="hylang repl">
  <body>
      <div id="terminal">
        <img src="{{ url_for('static', filename='symbolics.jpg') }}">
        <div id="hy-console" class="console"></div>
        <div id="footer"><a href='https://github.com/hylang/hy" target="_new">hylang/hy</a></div>
      </div>
  </body>
</html>]])

(defclass MyHyREPL [HyREPL]
  (defn eval [self code]
           (setv old-stdout sys.stdout)
           (setv old-stderr sys.stderr)
           (setv fake-stdout (StringIO))
           (setv sys.stdout fake-stdout)
           (setv fake-stderr (StringIO))
           (setv sys.stderr fake-stderr)
           (HyREPL.runsource self code "<input>" "single")
           (setv sys.stdout old-stdout)
           (setv sys.stderr old-stderr)
           {"stdout" (fake-stdout.getvalue) "stderr" (fake-stderr.getvalue)}))

(setv app (Flask __name__))

(with-decorator (app.route "/")
                  (defn index-page []
	            (render-template-string index-template
		                            :hy_version hy.__version__
		                            :server_software (get os.environ "SERVER_SOFTWARE"))
		  ))

(with-decorator (app.route "/eval" :methods ["POST"])
                  (defn eval-page []
		     (setv my-hy-repl (MyHyREPL)
		           eval-input (request.get_json))
                     (for [expr (get eval-input "env")]
                          (my-hy-repl.eval expr))
                     (json.dumps (my-hy-repl.eval (get eval-input "code")))
                  ))
