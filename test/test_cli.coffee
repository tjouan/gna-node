assert  = require 'assert'
CLI     = require 'cli'


describe 'CLI', ->
  args = ['coffee', 'gna', 'cmd']

  describe '.new', ->
    it 'assigns the arguments', ->
      cli = new CLI args
      assert.deepEqual args, cli.arguments

  describe '#run', ->
    it 'runs the given command', (done) ->
      command = class
        run: done
      cli = new CLI(args, { cmd: command })
      cli.run()
