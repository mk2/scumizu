sails = require 'sails'

before (done) ->
  @timeout 10000

  sails.lift
    hooks: grunt: false
    log:   level: 'debug'
    , (err) ->
      if err
        return done(err)
      else
        done(err, sails)

after (done) ->
  sails.lower done
