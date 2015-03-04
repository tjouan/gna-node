pkg = require '../package.json'


class Check
  @description: 'display status for registered repositories'

  run: ->
    console.log 'check'


class Discover
  @description: 'search and register repositories in `path\' directory'

  run: ->
    console.log 'discover'


class Help
  @description: 'display this message'

  run: ->
    console.log 'help'


class List
  @description: 'list registered repositories'

  run: ->
    console.log 'list'


class CLI
  COMMANDS:
    check:    Check
    discover: Discover
    help:     Help
    list:     List

  constructor: (argv) ->
    @argv     = argv
    @program  = require 'commander'
      .version pkg.version
    for name, klass of @COMMANDS
      @program
        .command name
        .description klass.description
        .action (cmd, _) =>
          (new @COMMANDS[cmd.name()]).run()
    @program
      .command '*'
      .action =>
        @program.outputHelp()

  run: ->
    @program.parse @argv


module.exports = CLI
