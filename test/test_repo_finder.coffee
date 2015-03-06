assert      = require 'assert'
RepoFinder  = require 'repo_finder'


describe 'RepoFinder', ->
  beforeEach ->
    @repo_finder = new RepoFinder '.'

  describe '#find', ->
    it 'returns git repositories paths', (done) ->
      @repo_finder.find (repos) ->
        assert.deepEqual ['.'], repos
        done()
