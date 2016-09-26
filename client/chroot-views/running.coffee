Template.ChrootViewRunning.helpers
  apps: ->
    Session.get 'apps'

Template.ChrootViewRunning.onCreated ->
  @apps = new ReactiveVar []

Template.ChrootViewRunning.onRendered ->
  {apps} = Template.instance()

  ###
  # TODO: use freedesktop to populate these
  @autorun =>
    return unless chroot = Template.currentData()

    runCmd chroot, 'whoami', (err, username) ->
      repoPath = "/home/#{username}/.romaine/apps"

      addX11App = (binary, name) ->
        json = JSON.stringify
          _id: binary
          name: name
          type: "x11"
          command: binary
        runCmdWithInput 'tee', ["#{repoPath}/#{binary}.json"], json, (err, output) ->
          console.log 'stored', binary, 'with', err ? output

      runCmd 'ls', repoPath, (err, output) ->
        if output.includes "#{repoPath}: No such file or directory"
          console.log 'Creating app repo'
          runCmd 'mkdir', '-p', repoPath, (err, output) ->
            addX11App 'xterm', 'Terminal'
            addX11App 'xeyes', 'xeyes'
            addX11App 'xcalc', 'Calculator'
            console.log 'All good'
        else
          Session.set 'apps', output.split("\n")
  ###

Template.ChrootViewRunning.events
  'click .app-list a': (evt) -> # launch app
    evt.preventDefault()
    app = @

    if chroot = Session.get 'chroot'
      runCmd 'whoami', (err, username) ->
        repoPath = "/home/#{username}/.romaine/apps"
        runCmd 'cat', "#{repoPath}/#{app}", (err, raw) ->
          manifest = JSON.parse raw
          if manifest.type is 'x11'
            runCmd 'xiwi', manifest.command, (err, out) ->
              # TODO: long-running
              console.log 'ran', manifest, 'with', err ? out
