Template.nav.helpers
  chroots: ->
    Chroots.find()

  chroot: ->
    Chroots.findOne(Session.get 'chroot')

  icon: -> switch @status
    when 'stopped' then switch
      when @encrypted then 'lock'
      else 'pause'
    when 'launching' then 'sync'
    when 'running' then 'play_arrow'
    when 'crashed' then 'error'

Template.nav.events
  'click .side-nav a': (evt) ->
    evt.preventDefault()
    Session.set 'chroot', @_id
