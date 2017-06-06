# isLoggedIn
#
# A simple policy that allows any request from an authenticated user.
#
# For more about how this policy works and how to use it, see:
#   https://sailsjs.com/anatomy/api/policies/isLoggedIn.js
module.exports = (req, res, next) ->
  if req.session.userId
    return next()
  else
    return res.redirect '/login'
