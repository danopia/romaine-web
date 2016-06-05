window.runCmdWithInput = (path, args, stdin, cb) ->
  connection.call '/commands/exec', Session.get('chroot'), path, args, stdin, (err, _id) ->
    Tracker.autorun (c) ->
      cmd = Commands.findOne(_id)
      return unless cmd?.output?
      c.stop()

      cb null, cmd.output

      setTimeout ->
        connection.call '/commands/expire', _id
      , 5000

window.runCmd = (path, args..., cb) ->
  connection.call '/commands/exec', Session.get('chroot'), path, args, (err, _id) ->
    Tracker.autorun (c) ->
      cmd = Commands.findOne(_id)
      return unless cmd?.output?
      c.stop()

      cb null, cmd.output

      setTimeout ->
        connection.call '/commands/expire', _id
      , 5000
