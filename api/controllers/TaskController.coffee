 # TaskController
 #
 # @description :: Server-side actions for handling incoming requests.
 # @help        :: See https://sailsjs.com/docs/concepts/actions
module.exports =

  create: (req, res) ->
    params = req.allParams()
    delete params.id
    delete params.createdAt
    delete params.updatedAt
    Task.create params
    .then () ->
      res.ok()
    .catch (err) ->
      res.redirect '/task'

  update: (req, res) ->
    id = req.param 'id'

  delete: (req, res) ->

  getCurrentSprintTasks: (req, res) ->
    sprint = null
    Sprint.findCurrentSprint()
    .then (sprint) ->
      Task.findSprintTasks sprint.id
    .then (tasks) ->
      res.json
        sprint: sprint
        tasks: tasks
    .catch (err) ->
      res.serverError err
