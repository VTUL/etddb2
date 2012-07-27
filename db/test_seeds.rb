# This file should contain seeds that will be used in testing,
# but are not required for a production environment.

Message.create(msg: 'This is a message', sender: Person.first, recipient: Person.where(pid: 'trailhead').first, read: false)
Message.create(msg: 'This is a message', sender: Person.last, recipient: Person.first, read: true)
