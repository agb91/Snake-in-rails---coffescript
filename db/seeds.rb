# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Utente.create(user: 'andrea', password: 'andrea', record1: 0, record2: 0, record3: 0)
Utente.create(user: 'secondo', password: 'secondo', record1: 0, record2: 0, record3: 0)
Utente.create(user: 'terzo', password: 'terzo', record1: 0, record2: 0, record3: 0)

Labirinto.create(livello: 1, xstart: 0, ystart: 0, direction:1, length:32)
Labirinto.create(livello: 1, xstart: 0, ystart: 0, direction:2, length:32)
Labirinto.create(livello: 1, xstart: 32, ystart: 0, direction:2, length:32)
Labirinto.create(livello: 1, xstart: 0, ystart: 32, direction:1, length:32)

Labirinto.create(livello: 2, xstart: 0, ystart: 1, direction:2, length:30)
Labirinto.create(livello: 2, xstart: 8, ystart: 1, direction:2, length:30)
Labirinto.create(livello: 2, xstart: 16, ystart: 1, direction:2, length:30)
Labirinto.create(livello: 2, xstart: 24, ystart: 1, direction:2, length:30)

Labirinto.create(livello: 3, xstart: 0, ystart: 1, direction:1, length:30)
Labirinto.create(livello: 3, xstart: 30, ystart: 1, direction:2, length:20)
Labirinto.create(livello: 3, xstart: 15, ystart: 20, direction:1, length:15)
Labirinto.create(livello: 3, xstart: 15, ystart: 10, direction:2, length:10)

Labirinto.create(livello: 4, xstart: 0, ystart: 0, direction:2, length:30)
Labirinto.create(livello: 4, xstart: 4, ystart: 0, direction:2, length:30)
Labirinto.create(livello: 4, xstart: 8, ystart: 0, direction:2, length:30)
Labirinto.create(livello: 4, xstart: 12, ystart: 0, direction:2, length:30)
Labirinto.create(livello: 4, xstart: 16, ystart: 2, direction:2, length:30)
Labirinto.create(livello: 4, xstart: 2, ystart: 2, direction:2, length:30)
Labirinto.create(livello: 4, xstart: 6, ystart: 2, direction:2, length:30)
Labirinto.create(livello: 4, xstart: 14, ystart: 2, direction:2, length:30)
