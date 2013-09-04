#!/usr/bin/which python
"""A simple Flask web application."""

import flask

app = flask.Flask(__name__) # pylint: disable=C0103

@app.route('/')
def index():
  """The index handler."""
  return flask.render_template('index.html')

if __name__ == '__main__':
  app.run(host = '0.0.0.0')
