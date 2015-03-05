commander = require 'commander'
pkg       = require '../package.json'


class Command
  constructor: (args) ->
    @args = args


class Check extends Command
  @description: 'display status for registered repositories'

  run: () ->
    console.log "check #{@args}"


class Discover extends Command
  @specification: 'discover <path>'
  @description:   'search and register repositories in `path\' directory'

  run: () ->
    console.log "discover #{@args}"


class List extends Command
  @description: 'list registered repositories'

  run: () ->
    console.log "list #{@args}"


class CLI
  EX_USAGE: 64

  COMMANDS:
    check:    Check
    discover: Discover
    list:     List

  constructor: (argv) ->
    @argv     = argv
    @program  = commander.version pkg.version
    for name, klass of @COMMANDS
      @program
        .command klass.specification ? name
        .description klass.description
        .action (args..., cmd) =>
          (new @COMMANDS[cmd.name()](args)).run()

  run: ->
    @program.parse @argv
    if @program.args.length == 0
      @program.outputHelp()
    else if typeof @program.args[0] == 'string'
      @program.outputHelp()
      process.exit @EX_USAGE


module.exports = CLI
