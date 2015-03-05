assert  = require 'assert'
CLI     = require '../lib/cli'


describe 'CLI', ->
  describe '.new', ->
    it 'assigns the arguments', ->
      cli = new CLI [1, 2]
      assert.deepEqual [1, 2], cli.arguments

  describe '#run', ->
    it 'runs the given command', (done) ->
      command = class
        run: done
      cli = new CLI(['coffee', 'gna', 'cmd'], { cmd: command })
      cli.run()
