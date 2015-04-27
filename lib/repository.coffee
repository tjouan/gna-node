child_process = require 'child_process'


class Repository
  constructor: (path) ->
    @path = path

  check: (f) ->
    child_process.exec "git -C #{@path} symbolic-ref --short HEAD",
      (err, stdout, stderr) =>
        throw err if err
        f """
          *** #{@path} ***
          #{stdout}
          """


module.exports = Repository
