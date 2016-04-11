window.connection = DDP.connect 'http://localhost:6206/app'
connection.subscribe 'chroot list'

window.Chroots = new Mongo.Collection 'chroots', {connection}
Chroots.find().observe
  added: (doc) ->
    console.group 'add', doc._id
    console.log 'added', doc
    console.log x for x in Chroots.find().fetch()
    console.groupEnd()

  changed: (doc, old) ->
    console.group 'change', doc._id
    console.log 'changed', doc, 'from', old
    console.log x for x in Chroots.find().fetch()
    console.groupEnd()

  removed: (doc) ->
    console.group 'remove', doc._id
    console.log 'removed', doc
    console.log x for x in Chroots.find().fetch()
    console.groupEnd()
