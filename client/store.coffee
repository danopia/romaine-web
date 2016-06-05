window.connection = DDP.connect 'http://localhost:6206/app'

connection.subscribe 'chroots'
window.Chroots = new Mongo.Collection 'chroots', {connection}
Chroots.find().observe
  added: (doc) ->
    console.group 'add chroot', doc._id
    console.log 'added', doc
    #console.log x for x in Chroots.find().fetch()
    console.groupEnd()

  changed: (doc, old) ->
    console.group 'change chroot', doc._id
    console.log 'changed', doc, 'from', old
    #console.log x for x in Chroots.find().fetch()
    console.groupEnd()

  removed: (doc) ->
    console.group 'remove chroot', doc._id
    console.log 'removed', doc
    #console.log x for x in Chroots.find().fetch()
    console.groupEnd()

connection.subscribe 'commands'
window.Commands = new Mongo.Collection 'commands', {connection}
Commands.find().observe
  added: (doc) ->
    console.group 'add command', doc._id
    console.log 'added', doc
    #console.log x for x in Commands.find().fetch()
    console.groupEnd()

  changed: (doc, old) ->
    console.group 'change command', doc._id
    console.log 'changed', doc, 'from', old
    #console.log x for x in Commands.find().fetch()
    console.groupEnd()

  removed: (doc) ->
    console.group 'remove command', doc._id
    console.log 'removed', doc
    #console.log x for x in Commands.find().fetch()
    console.groupEnd()
