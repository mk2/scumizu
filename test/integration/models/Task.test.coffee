sails = require 'sails'
assert = require 'assert'
util = require '../../fixtures/task.utils'

describe 'タスク作成と検索のテスト', () ->

  sprint1 = null
  tasks1 = []
  tasks1ids = []
  sprint2 = null
  tasks2 = []
  tasks2ids = []
  sprint3 = null
  tasks3 = []
  tasks3ids = []
  now = +(new Date())
  twoWeeks = 60 * 60 * 24 * 7 * 2
  backlog = null

  describe 'スプリント作成・検索テスト', () ->

    it 'バックログスプリント存在チェック', (done) ->
      Sprint.findBacklog (err, _backlog) ->
        if err
          done(err)
        else
          backlog = _backlog
          done()
      return

    it 'スプリント#1作成テスト', (done) ->
      Sprint.create
        name: "Test Sprint #1 (#{now})"
        memo: ""
        startDate: now - twoWeeks
        endDate: now - 1
      .meta fetch: true
      .exec (err, sprint) ->
        if err
          done(err)
        else
          sprint1 = sprint
          done()
      return

    it 'スプリント#2作成テスト', (done) ->
      Sprint.create
        name: "Test Sprint #2 (#{now})"
        memo: ""
        startDate: now
        endDate: now + twoWeeks - 1
      .meta fetch: true
      .exec (err, sprint) ->
        if err
          done(err)
        else
          sprint2 = sprint
          done()
      return

    it 'スプリント#3作成テスト', (done) ->
      Sprint.create
        name: "Test Sprint #3 (#{now})"
        memo: ""
        startDate: now + twoWeeks
        endDate: now + 2 * twoWeeks - 1
      .meta fetch: true
      .exec (err, sprint) ->
        if err
          done(err)
        else
          sprint3 = sprint
          done()
      return

    return # return for 'スプリント作成テスト'

  describe 'タスク作成・設定テスト', () ->

    _tasksInSprint1 = [
      util.withDefaults
        name: 'Task 1 (Sprint1)'
      util.withDefaults
        name: 'Task 2 (Sprint1)'
      util.withDefaults
        name: 'Task 3 (Sprint1)'
    ]

    _tasksInSprint2 = [
      util.withDefaults
        name: 'Task 1 (Sprint2)'
      util.withDefaults
        name: 'Task 2 (Sprint2)'
      util.withDefaults
        name: 'Task 3 (Sprint2)'
    ]

    _tasksInSprint3 = [
      util.withDefaults
        name: 'Task 1 (Sprint3)'
      util.withDefaults
        name: 'Task 2 (Sprint3)'
      util.withDefaults
        name: 'Task 3 (Sprint3)'
    ]

    _tasksInSprint1.forEach (task, i) ->
      it "タスク作成 (Sprint1) #{i}", (done) ->
        task.sprint = sprint1.id
        Task.create task
        .meta fetch: true
        .exec (err, task) ->
          if err
            done(err)
          else
            Task.findOne
              id: task.id
            .populate 'sprint'
            .exec (err, _task) ->
              if err
                done(err)
              else
                assert _task.sprint.id is sprint1.id
                tasks1.push _task
                tasks1ids.push _task.id
                done()
        return

    _tasksInSprint2.forEach (task, i) ->
      it "タスク作成 (Sprint2) #{i}", (done) ->
        task.sprint = sprint2.id
        Task.create task
        .meta fetch: true
        .exec (err, task) ->
          if err
            done(err)
          else
            Task.findOne
              id: task.id
            .populate 'sprint'
            .exec (err, _task) ->
              if err
                done(err)
              else
                assert _task.sprint.id is sprint2.id
                tasks2.push _task
                tasks2ids.push _task.id
                done()
        return

    _tasksInSprint3.forEach (task, i) ->
      it "タスク作成 (Sprint3) #{i}", (done) ->
        task.sprint = sprint3.id
        Task.create task
        .meta fetch: true
        .exec (err, task) ->
          if err
            done(err)
          else
            Task.findOne
              id: task.id
            .populate 'sprint'
            .exec (err, _task) ->
              if err
                done(err)
              else
                assert _task.sprint.id is sprint3.id
                tasks3.push _task
                tasks3ids.push _task.id
                done()
        return

    it '現在のスプリントのタスク一覧取得・IDチェック', (done) ->
      Sprint.findCurrentSprint (err, sprint) ->
        if err
          done(err)
        else
          assert sprint.id is sprint2.id
          Task.findSprintTasks sprint.id
          , (err, tasks) ->
            for task in tasks
              assert task.id in tasks2ids
            done()
      return

    it 'タスクをBacklogに移す', (done) ->
      Sprint.findCurrentSprint (err, sprint) ->
        if err
          done(err)
        else
          Task.findSprintTasks sprint.id
          , (err, tasks) ->
            checks = []
            for task in tasks
              checks.push new Promise (resolve, reject) ->
                Task.moveToBacklog id: task.id
                  .then () ->
                    Task.findOne
                      id: task.id
                    .populate 'sprint'
                  .then (_task) ->
                    assert _task.id is task.id
                    resolve()
                  .catch (err) ->
                    reject(err)
            Promise.all checks
            .then () ->
              done()
            .catch (err) ->
              done(err)
            return
      return

    return # return for 'タスク作成・設定テスト'

  return
