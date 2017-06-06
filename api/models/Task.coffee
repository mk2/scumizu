 # Task.coffee
 #
 # @description :: A model definition.  Represents a database table/collection/etc.
 # @docs        :: https://sailsjs.com/docs/concepts/models-and-orm/models

module.exports =

  # 指定されたスプリントIDのタスクを全て取得する
  # @param sprintId {number}
  # @param cb       {nodeback}
  # @returns        {Promise}
  findSprintTasks: (sprintId, cb) ->
    Task.find
      sprint: sprintId
    .then (tasks) ->
      cb?(null, tasks)
    .catch (err) ->
      cb?(err)
      throw err

  # 指定したスプリントにタスクを移動する
  # @param opts {object}   sprintId ... 移動先スプリントID
  #                        taskId   ... 移動させるタスクID
  # @param cb   {nodebacks}
  # @returns    {Promise}
  moveToSprint: (opts, cb) ->
    Task.update
      id:     opts.taskId
    , sprint: sprint.id
    .meta fetch: opts.fetch? false
    .then (task) ->
      cb?(task)
    .catch (err) ->
      cb?(err)
      throw err

  # タスクをバックログに移動する
  # @param opts {object} taskId ... タスクのID
  #                      fetch  ... 更新後のタスクをフェッチするかどうか
  # @param cb   {nodebacks}
  # @returns    {Promise}
  moveToBacklog: (opts, cb) ->
    Sprint.findBacklog()
    .then (backlog) ->
      Task.update
        id:     opts.taskId
      , sprint: backlog.id
      .meta fetch: opts.fetch? false
    .then (task) ->
      cb?(null, task)
    .catch (err) ->
      cb?(err)
      throw err


  tableName: 'scmz_task'

  attributes:

    description:
      type:       'string'
      columnType: 'text'
      defaultsTo: ''

    status:
      type:       'string'
      columnType: 'varchar(32)'
      isIn:       ['Not Started', 'In Progress', 'Reopended', 'Blocked', 'Completed', 'Duplicate', 'Will Not Do']
      defaultsTo: 'Not Started'

    level:
      type:       'number'
      columnType: 'tinyint'
      defaultsTo: 0

    position:
      type:       'number'
      columnType: 'bigint'
      defaultsTo: 0

    owner:
      type:       'string'
      columnType: 'varchar(64)'
      defaultsTo: ''

    priority:
      type:       'number'
      columnType: 'tinyint'

    difficulty:
      type:       'number'
      columnType: 'float'
      defaultsTo: 1.0

    estimate:
      type:       'number'
      columnType: 'float'

    remain:
      type:       'number'
      columnType: 'float'

    sprint:
      model:      'Sprint'
