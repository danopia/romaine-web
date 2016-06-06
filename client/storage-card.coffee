Session.set 'root disk info', {}

Template.StorageCard.onCreated ->
  @autorun -> if chroot = Session.get 'chroot'
    runCmd 'df', '-T', '/', (err, raw) ->
      info = raw.split("\n")[1].split(/ +/)
      Session.set 'root disk info',
        device: info[0]
        fs: info[1]
        size: +info[2]
        used: +info[3]
        avail: +info[4]

Template.StorageCard.helpers
  diskUsage: ->
    {used, size} = Session.get 'root disk info'
    used / size * 100

  diskSize: ->
    {size} = Session.get 'root disk info'
    Math.round(size / 1024 / 1024 * 10) / 10

  diskUsed: ->
    {used} = Session.get 'root disk info'
    Math.round(used / 1024 / 1024 * 10) / 10

  diskAvail: ->
    {avail} = Session.get 'root disk info'
    Math.round(avail / 1024 / 1024 * 10) / 10

  device: ->
    {device, fs} = Session.get 'root disk info'
    "#{fs} #{device}"
