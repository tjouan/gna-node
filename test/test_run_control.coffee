assert  = require 'assert'
fs      = require 'fs'
rc      = require 'run_control'


describe 'RunControl', ->
  rc_path = 'tmp/gna.rc'

  beforeEach ->
    rc.FILE_PATH = rc_path
    fs.mkdir 'tmp', (e) ->
      throw e if e?.code? and e.code != 'EEXIST'
      fs.unlink rc_path

  describe '#readRepos', ->
    it 'saves given paths in the run control config file', (done) ->
      fs.writeFile rc_path, "foo\nbar\n", (err) ->
        throw err if err
        rc.readRepos (repos) ->
          assert.deepEqual ['foo', 'bar'], repos
          done()

  describe '#saveRepos', ->
    it 'saves given paths in the run control config file', (done) ->
      rc.saveRepos ['foo', 'bar'], ->
        fs.readFile rc_path, encoding: 'utf8', (_, data) ->
          assert.equal "foo\nbar\n", data
          done()
