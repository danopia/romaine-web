Template.AppList.onRendered ->
  @$('.collapsible').collapsible
    accordion: true

Template.AppList.helpers
  directories: ->
    chroot = Template.currentData()
    FdApps.find({
      Chroot: chroot._id
      'Entry.Type': 'Directory'
    }).fetch()
    .filter (app) ->
      FdApps.find({
        Chroot: app.Chroot
        'Entry.Type': 'Application'
        'Entry.Categories': app.Entry.Name
        'Entry.OnlyShowIn': null
        'Entry.NoDisplay': $ne: true
      }).count()
    #.map (ent) -> ent.Entry

  apps: ->
    {Chroot, Entry} = Template.currentData()
    FdApps.find({
      Chroot
      'Entry.Type': 'Application'
      'Entry.Categories': Entry.Name
      'Entry.OnlyShowIn': null
      'Entry.NoDisplay': $ne: true
    })#.map (ent) -> ent.Entry
