commander = require 'commander'
pkg       = require '../package.json'

RunControl  = require './run_control'
RepoFinder  = require './repo_finder'


class Command
  constructor: (args) ->
    @args = args


class Check extends Command
  @description: 'display status for registered repositories'

  run: ->
    console.log "check #{@args}"


class Discover extends Command
  @specification: 'discover <path>'
  @description:   'search and register repositories in `path\' directory'

  run: ->
    (new RepoFinder @args[0]).find (repos) ->
      RunControl.saveRepos repos

class List extends Command
  @description: 'list registered repositories'

  run: ->
    console.log "list #{@args}"


class CLI
  EX_USAGE: 64

  COMMANDS:
    check:    Check
    discover: Discover
    list:     List

  constructor: (argv, commands = @COMMANDS) ->
    @arguments  = argv
    @program    = commander.version pkg.version
    for name, klass of commands
      @program
        .command klass.specification ? name
        .description klass.description
        .action (args..., cmd) ->
          (new commands[cmd.name()](args)).run()

  run: ->
    @program.parse @arguments
    if @program.args.length == 0
      @program.outputHelp()
    else if @program.args.length == 1 && typeof @program.args[0] == 'string'
      @program.outputHelp()
      process.exit @EX_USAGE


module.exports = CLI
