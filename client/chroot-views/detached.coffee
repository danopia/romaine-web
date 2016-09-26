Template.ChrootViewDetached.events
  'click a.mount': (evt) ->
    evt.preventDefault()

    # no need to decrypt - already mounted

    connection.call 'start chroot', @_id, (err, out) ->
      console.log 'Chroot launch returned', err ? out
