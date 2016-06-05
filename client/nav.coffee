Template.nav.helpers
  chroot: -> Chroots.find()

Template.nav.events
  'click a': (evt) ->
    evt.preventDefault()
    Session.set 'chroot', @_id
