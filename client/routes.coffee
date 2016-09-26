Router.configure
  layoutTemplate: 'Layout'

Router.route '/chroots/:chroot',
  name: 'chroot.view'
  # subscriptions: -> @subscribe @params...
  data: -> Chroots.findOne @params.chroot
  action: ->
    unless chroot = @data()
      return @render 'Loading'

    {_id, status} = chroot
    Session.set 'chroot', _id

    template = status[0].toUpperCase() + status.slice(1)
    @render 'ChrootView' + template

Router.route '/'
