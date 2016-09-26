Template.ChrootViewStopped.events
  'click a.mount': (evt) ->
    evt.preventDefault()

    password = null
    if @encrypted
      password = prompt 'Encryption password:'
      return unless password

    connection.call 'start chroot', @_id, password, (err, out) ->
      console.log 'Chroot launch returned', err ? out
