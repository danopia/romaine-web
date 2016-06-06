window.Entries = new Mongo.Collection null

Template.AppList.onRendered ->
  @$('.collapsible').collapsible
    accordion: true

  @autorun ->
    chroot = Session.get 'chroot'
    updateEntries chroot, '/usr/share/desktop-directories', 'Directory', '.directory'
    updateEntries chroot, '/usr/share/applications', 'Application', '.desktop'

Template.AppList.helpers
  directories: ->
    chroot = Session.get 'chroot'
    Entries.find {chroot, Type: 'Directory'}

  hasApps: ->
    chroot = Session.get 'chroot'
    Entries.find({chroot, Type: 'Application', Categories: @Name}).count() > 0

  apps: ->
    chroot = Session.get 'chroot'
    Entries.find {chroot, Type: 'Application', Categories: @Name}

BOOLS = ['NoDisplay', 'Hidden', 'DBusActivatable', 'Terminal', 'StartupNotify']
LISTS = ['OnlyShowIn', 'NotShowIn', 'Actions', 'MimeType', 'Categories', 'Implements', 'Keywords']

updateEntries = (chroot, root, Type, extension) ->
  runCmd 'find', root, (err, list) ->
    Entries.remove {chroot, Type}, (err) ->
      list.split("\n").forEach (path) ->
        return unless path.endsWith extension
        subpath = path.slice(root.length + 1)

        setTimeout ->
          runCmd 'cat', path, (err, raw) ->
            obj = {}
            raw.split "\n"
              .filter (x) -> x.includes '='
              .map (x) -> [x.split('=', 1)[0], x.slice(x.indexOf('=')+1)]
              .filter ([key]) -> not key.includes('[') # Ignore translations for now
              .forEach ([key, val]) ->
                obj[key] = switch
                  when key in BOOLS then val in ['true', '1']
                  when key in LISTS
                    val = val.slice(0, -1) if val.endsWith ';'
                    val.split(';')
                  else val

            obj._id = subpath
            obj.chroot = chroot
            Entries.insert obj, (err) ->
        , Math.round(Math.random() * 5000)
