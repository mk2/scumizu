 # PageController
 #
 # @description :: Server-side actions for handling incoming requests.
 # @help        :: See https://sailsjs.com/docs/concepts/actions
module.exports =

  index: (req, res) ->
    res.view 'index'

  backlog: (req, res) ->
    res.view 'backlog'

  sprints: (req, res) ->
    Sprint.find().exec (err, sprints) ->
      if err then res.serverError err else res.view 'sprint/view', sprints: sprints

  sprintCreate: (req, res) ->
    res.view 'sprint/edit',
      apiUrl:    '/api/sprint/create'
      apiMethod: 'POST'
      title:     'Create Sprint!'
      sprint:    {}

  sprintUpdate: (req, res) ->
    Sprint.findOne req.param 'id'
    .then (sprint) ->
      res.view 'sprint/edit',
        apiUrl:    "/api/sprint/update/#{sprint.id}"
        apiMethod: 'POST'
        title:     'Update Sprint!'
        sprint:    sprint

  login: (req, res) ->
    if req.session.userId
      res.view 'index'
    else
      res.view 'user/login',
        warnings: []

  signup: (req, res) ->
    if req.session.userId
      res.view 'index'
    else
      res.view 'user/signup',
        warnings: []

  logout: (req, res) ->
    if req.session.userId
      # do logout
    else
      # not require to logout
      res.top()
