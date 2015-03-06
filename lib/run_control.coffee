fs = require 'fs'


RunControl =
  FILE_PATH: "#{process.env.HOME}/.gna.rc"

  saveRepos: (repos, done) ->
    fs.writeFile @FILE_PATH, repos.join("\n") + "\n", (err) ->
      throw err if err
      done?()


module.exports = RunControl
