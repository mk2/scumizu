 # UserController
 #
 # @description :: Server-side actions for handling incoming requests.
 # @help        :: See https://sailsjs.com/docs/concepts/actions

bcrypt     = require 'bcryptjs'
saltRounds = sails.config.auth.saltRounds

module.exports =

  login: (req, res) ->
    password = req.param 'password'
    email    = req.param 'email'

    User.findOne
      email: email
    .then (user) ->
      bcrypt.compare password, user.password, (err, matched) ->
        if matched
          req.session.userId = user.id
          res.redirect '/'
        else
          res.badRequest 'invalid password'
    .catch (err) ->
      res.badRequest err

    bcrypt.hash password, saltRounds, (err, hash) ->
      res.serverError err if err

      User.findOne
        email: email
        password: hash
      .then (user) ->
        sails.log user
        if user
          req.session.userId = user.id
          res.top()
      .catch (err) ->
        res.badRequest err

  logout: (req, res) ->
    delete req.session.userId
    res.top()

  signup: (req, res) ->
    name     = req.param 'name'
    password = req.param 'password'
    email    = req.param 'email'

    bcrypt.hash password, saltRounds, (err, hash) ->
      res.serverError err if err

      User.create
        name: name
        password: hash
        email: email
      .meta
        fetch: true
      .then (user) ->
        req.session.userId = user.id
        res.top()
