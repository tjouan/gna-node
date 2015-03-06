fs = require 'fs'


RunControl =
  FILE_PATH: "#{process.env.HOME}/.gna.rc"

  readRepos: (f) ->
    fs.readFile @FILE_PATH, encoding: 'utf8', (err, data) ->
      f data.split(/\n/).filter (e) -> e

  saveRepos: (repos, done) ->
    fs.writeFile @FILE_PATH, repos.join("\n") + "\n", (err) ->
      throw err if err
      done?()


module.exports = RunControl
