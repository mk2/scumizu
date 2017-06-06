sails = require 'sails'

module.exports =

  withDefaults: (opts) ->
    return
      description: opts.description ? '--'
      status:      opts.status      ? 'Not Started'
      owner:       opts.owner       ? 'scumizu'
      priority:    opts.priority    ? 3
      estimate:    opts.estimate    ? 1.0
      level:       opts.level       ? 0
      position:    opts.position    ? 0
      difficulty:  opts.diffculty   ? 1.0
      remain:      opts.remain      ? 0.1
      sprint:      opts.sprint      ? null
      name:        opts.name        ? "Task #{+(new Date)}"
