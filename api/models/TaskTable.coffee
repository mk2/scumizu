 # TaskTable.coffee
 #
 # @description :: A model definition.  Represents a database table/collection/etc.
 # @docs        :: https://sailsjs.com/docs/concepts/models-and-orm/models

module.exports =

  # 全ての親を取得する
  findAllParents: (opts, cb) ->
    sails.getDataStore().sendNativeQuery(
      'SELECT ancestor FROM $1 WHERE descendant = $2'
      [TaskTable.tableName, opts.id]
    ).exec (err, rawResults) ->
      if err then cb(err) else cb(null, rawResults)
      cb(rawResults)

  # 指定された子の親を全て作る
  createAllParentsPath: (opts, cb) ->
    ancIds = opts.parentIds
    desId  = opts.id
    values = ("(#{ancId}, #{desId})" for ancId in ancIds).join(',')
    sails.getDataStore().sendNativeQuery(
      'INSERT INTO $1 VALUES $2'
      [TaskTable.tableName, values]
    ).exec (err) ->
      if err then cb(err) else cb()

  tableName: 'scmz_task_table'

  attributes:

    ancestor:
      type:       'number'
      columnType: 'bigint'

    descendant:
      type:       'number'
      columnType: 'bigint'

    distance:
      type:       'number'
      columnType: 'bigint'
