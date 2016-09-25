Template.AppList.onRendered ->
  @$('.collapsible').collapsible
    accordion: true

Template.AppList.helpers
  directories: ->
    Chroot = Session.get 'chroot'
    FdApps.find({
      Chroot
      'Entry.Type': 'Directory'
    }).map (ent) -> ent.Entry

  hasApps: ->
    Chroot = Session.get 'chroot'
    FdApps.find({
      Chroot
      'Entry.Type': 'Application'
      'Entry.Categories': @Name
    }).count() > 0

  apps: ->
    Chroot = Session.get 'chroot'
    FdApps.find({
      Chroot
      'Entry.Type': 'Application'
      'Entry.Categories': @Name
    }).map (ent) -> ent.Entry
