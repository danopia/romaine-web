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
    when 'detached' then 'help_outline'
    when 'running' then 'play_arrow'
    when 'crashed' then 'error'
