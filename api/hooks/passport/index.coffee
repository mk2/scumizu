passport = require 'passport'
LocalStrategy = require('passport-local').Strategry

module.exports = (sails) ->

  # hook用の初期化メソッド
  initialize: (cb) ->
    sails.after 'hook:orm:loaded', ->
      err = null
      UserModel = sails.models['User']

      if !UserModel
        err = new Error()
        err.message = 'Failed to sails initialize'
        return cb(err)

      sails.passport = passport
      # TODO
