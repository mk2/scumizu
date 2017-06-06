 # SprintController
 #
 # @description :: Server-side actions for handling incoming requests.
 # @help        :: See https://sailsjs.com/docs/concepts/actions

extractDate = (req) ->
  start_date = req.param 'start_date'
  end_date   = req.param 'end_date'
  startDate  = if typeof start_date is 'undefined' then parseInt '' + sails.moment start_date else +(new Date())
  endDate    = if typeof end_date   is 'undefined' then parseInt '' + sails.moment end_date   else +(new Date())
  {startDate, endDate}

module.exports =

  create: (req, res) ->
    name = req.param 'name'
    memo = req.param 'memo'
    isLocked = req.param 'isLocked', false
    isHidden = req.param 'isHidden', false
    {startDate, endDate} = extractDate req

    Sprint.create
      name: name
      memo: memo
      startDate: startDate
      endDate:   endDate
      isLocked: isLocked
      isHidden: isHidden
    .exec (err) ->
      if err then res.serverError err else res.sprints()

  update: (req, res) ->
    id   = req.param 'id'
    name = req.param 'name'
    memo = req.param 'memo'
    {startDate, endDate} = extractDate req

    Sprint.update
      id: id
    , name: name
      memo: memo
      startDate: startDate
      endDate: endDate
    .exec (err) ->
      if err then res.serverError err else res.sprints()
