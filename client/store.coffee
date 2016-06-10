window.connection = DDP.connect 'http://localhost:6206/app'

connection.subscribe 'chroots'
window.Chroots = new Mongo.Collection 'chroots', {connection}

connection.subscribe 'commands'
window.Commands = new Mongo.Collection 'commands', {connection}

# Freedesktop App/Directory cache
connection.subscribe 'fd-apps'
window.FdApps = new Mongo.Collection 'fd-apps', {connection}
