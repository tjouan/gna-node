assert        = require 'assert'
child_process = require 'child_process'
Repository    = require 'repository'


describe 'RunControl', ->
  repo_path = 'tmp/repo'

  beforeEach ->
    @repo = new Repository repo_path

  describe '#check', ->
    it 'executes git commands to query repository status', (done) ->
      child_process.exec = (command, options, f) ->
        assert.equal "git -C #{repo_path} symbolic-ref --short HEAD", command
        done()
      @repo.check ->

    it 'returns git output', (done) ->
      child_process.exec = (command, f) ->
        f null, """
          master
           M README

          """,
          ''
      @repo.check (output) ->
        assert.equal """
          *** #{repo_path} ***
          master
           M README

          """,
          output
        done()
