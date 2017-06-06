 # Sprint.coffee
 #
 # @description :: A model definition.  Represents a database table/collection/etc.
 # @docs        :: https://sailsjs.com/docs/concepts/models-and-orm/models

module.exports =

  findBacklog: (cb) ->
    Sprint.findOne
      name: 'backlog'
    .then (backlog) ->
      cb?(null, backlog)
    .catch (err) ->
      cb?(err)

  findCurrentSprint: (cb) ->
    now = +(new Date())
    Sprint.findOne
      startDate: '<=': now
      endDate:   '>=':  now
    .then (sprint) ->
      cb?(null, sprint)
    .catch (err) ->
      cb?(err)

  tableName: 'scmz_sprint'

  attributes:

    tasks:
      collection: 'Task'
      via:        'sprint'

    name:
      type:       'string'
      columnType: 'varchar(128)'

    memo:
      type:       'string'
      columnType: 'text'

    startDate:
      type:       'number'
      columnType: 'bigint'

    endDate:
      type:       'number'
      columnType: 'bigint'

    isLocked:
      type:       'boolean'
      defaultsTo: false

    isHidden:
      type:       'boolean'
      defaultsTo: false
