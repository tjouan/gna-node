glob = require 'glob'


class RepoFinder
  constructor: (path) ->
    @path = path

  find: (f) ->
    glob "#{@path}/**/.git", (err, repos) -> f repos.map (e) -> e[0..-6]


module.exports = RepoFinder
