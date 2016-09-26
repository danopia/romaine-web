Template.ChrootViewStopped.events
  'click a.mount': (evt) ->
    evt.preventDefault()

    password = if @encrypted
      prompt 'Encryption password:'

    connection.call 'start chroot', @_id, password, (err, out) ->
      console.log 'Chroot launch returned', err ? out
