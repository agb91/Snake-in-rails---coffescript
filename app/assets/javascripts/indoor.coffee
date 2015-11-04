$('#nascondi').hide();
serpente = ['4u7','4u6','4u5','4u4']
time = 200
direzione = 'right'
morto = 0
punti = 0
barando = 0

window.addEventListener "keydown", (e) => keyb e.keyCode

keyb = (i) ->
   upkey() if i==38
   downkey() if i==40
   rightkey() if i==39
   leftkey() if i==37
   unHide() if i==80

upkey = ->
   direzione = 'up'

downkey = ->
   direzione = 'down'

rightkey = ->
   direzione = 'right'

leftkey = ->
   direzione = 'left'

color = (col, id) ->
  cid = '#'+id
  $(cid).css('background-color',col)
  $(cid).css('border-radius','0px')

round = (id) ->
  cid = '#'+id
  $(cid).css('border-radius','7px')

getColor = (id) ->
  cid = '#'+id
  $(cid).css('background-color')

nero = getColor '4u7'

setLabirinth = (l)->
  bars = l.length
  for i in [0..bars-1]
    livello = l[i].level
    xstart = l[i].xstart
    ystart = l[i].ystart
    length = l[i].length
    direction = l[i].direction
    #alert livello + "; "+ xstart + "; "+ ystart + "; "+ length + "; "+ direction
    ostacolo = getLabVector(livello,xstart,ystart,length,direction)
    writeLabirinth ostacolo

writeLabirinth = (ostacolo) ->
  for i in [0..ostacolo.length-1]
     color('blue' , ostacolo[i])

getLabVector = (livello, xstart, ystart, length, direction) ->
  if parseInt(direction)==2
     ostacolo = getLabVector2(xstart, ystart ,length)
  else
     ostacolo = getLabVector1(xstart, ystart ,length) if parseInt(direction)==1
  return ostacolo

getLabVector2 = (xstart, ystart, length) ->
  os2 = []
  for i in [0..length]
     id = parseInt(parseInt(ystart)+i) + "u" + xstart
     os2[i]= id
  return os2

getLabVector1 = (xstart, ystart, length) ->
  os1 = []
  for i in [0..length]
     id = ystart + "u" + parseInt(parseInt(xstart)+i)
     os1[i]= id
  return os1

readJSON = (livello) ->
  $.getJSON '/get_labi.json', (data) ->
    a = data.get_labi.length
    ris = []
    n = 0
    for i in [0..a-1]
      attuale = data.get_labi[i].level
      if parseInt(attuale)==parseInt(livello)
        ris[n] = data.get_labi[i]
        n = n+1
    setLabirinth(ris)

leggiPunti = ->
  punti = $('#actualRecord').text().trim()

unHide = ->
  for c in [32..37]
    for r in [15..32]
      $("#"+r+"u"+c).css("opacity",1);
      #$("#"+r+"u"+c).css("border","1px solid blue");
  for c in [10..25]
    for r in [34..37]
      $("#"+r+"u"+c).css("opacity",1);
      #$("#"+r+"u"+c).css("border","1px solid blue");
  for c in [10..14]
    for r in [32..34]
      $("#"+r+"u"+c).css("opacity",1);
      #$("#"+r+"u"+c).css("border","1px solid blue");
  barando = 1

window.avvia = (l) ->
  leggiPunti()
  readJSON(l)
  draw()
  food()
  setInterval(forward, time)

getRandomInt = (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

food = ->
  rr = getRandomInt(1,31)
  rc = getRandomInt(1,31)
  c = getColor (rr+'u'+rc)
  l = c.length
  ris = c.substring(4,l-1).split(',')
  r1 = parseInt(ris[0])
  r2 = parseInt(ris[1])
  r3 = parseInt(ris[2])
  if r1==255 && r2==255 && r3==0
    color('red',rr+'u'+rc)
  else
    food()

checkAlive = (id) ->
  alive = true
  c = getColor id
  l = c.length
  ris = c.substring(4,l-1).split(',')
  r1 = parseInt(ris[0])
  r2 = parseInt(ris[1])
  r3 = parseInt(ris[2])
  alive = false if r1==0 && r2==0 && r3==0
  alive = false if r1==0 && r2==0 && r3==255
  death() if alive is false && morto == 0
  morto = 1 if alive is false
  return alive

death = ->
    window.location.href = '/postmortem/index?data='+punti

checkFood = (id) ->
  food = false
  c = getColor id
  l = c.length
  ris = c.substring(4,l-1).split(',')
  r1 = parseInt(ris[0])
  r2 = parseInt(ris[1])
  r3 = parseInt(ris[2])
  food = true if r1==255 && r2==0 && r3==0
  return food

getOpacity = (id) ->
  cid = '#'+id
  $(cid).css('opacity')

larghezzaRiga = (ri) ->
  record = 0
  cont = 0
  for i in [0..37]
    id = ri+"u"+i
    col = getColor(id)
    l=col.length
    ris = col.substring(4,l-1).split(',')
    r1 = parseInt(ris[0])
    r2 = parseInt(ris[1])
    r3 = parseInt(ris[2])
    opa = getOpacity(id)
    opa = parseInt(opa)
    cont=cont+1 if r1==255 && r2==255 && r3==0 && opa==1
    cont=cont+1 if r1==0 && r2==0 && r3==0
    cont=cont+1 if r1==255 && r2==0 && r3==0
    cont = 0 if opa==0
    if opa==0
      if cont>record
        record = cont
      cont = 0
    if cont>record
      record = cont
  return record

altezzaColonna = (co, riga) ->
  giusta = 0
  cont = 0
  for i in [0..37]
    if i == riga
      giusta = 1
    id = i+"u"+co
    col = getColor(id)
    l=col.length
    ris = col.substring(4,l-1).split(',')
    r1 = parseInt(ris[0])
    r2 = parseInt(ris[1])
    r3 = parseInt(ris[2])
    opa = getOpacity(id)
    opa = parseInt(opa)
    cont=cont+1 if r1==255 && r2==255 && r3==0 && opa==1
    cont=cont+1 if r1==0 && r2==0 && r3==0
    cont=cont+1 if r1==255 && r2==0 && r3==0
    if opa==0
      if giusta == 1
        record = cont
        giusta = 2
      cont = 0
  if giusta == 1
    record = cont
  return record

fuori = (id) ->
  ris = false
  if parseInt(getOpacity(id))==0
    ris = true
    #alert 'opaco!'
  ri = parseInt(id.split('u')[0])
  co = parseInt(id.split('u')[1])
  if ri>37 or ri<0 or co>37 or co<0
    ris=true
    #alert 'fuori confini'
  return ris

forwardRight = (vecchia) ->
   ri = parseInt(vecchia.split('u')[0])
   colonna = parseInt(parseInt(vecchia.split('u')[1])+1)
   id = ri + 'u' + colonna
   if fuori(id)
     colonna = parseInt(colonna) - parseInt(larghezzaRiga ri)
   id = ri + 'u' + colonna
   return id

forwardLeft = (vecchia) ->
   ri = parseInt(vecchia.split('u')[0])
   colonna = parseInt(parseInt(vecchia.split('u')[1])-1)
   id = ri + 'u' + colonna
   if fuori(id)
     colonna = colonna + parseInt(larghezzaRiga ri)
   id = ri + 'u' + colonna
   return id

forwardUp = (vecchia) ->
   co = parseInt(vecchia.split('u')[1])
   riga = parseInt(parseInt(vecchia.split('u')[0])-1)
   id = riga + 'u' + co
   if fuori(id)
     riga = parseInt(riga) + parseInt(altezzaColonna(co,parseInt(riga+1)))
   id = riga + 'u' + co
   return id

forwardDown = (vecchia) ->
   co = parseInt(vecchia.split('u')[1])
   riga = parseInt(parseInt(vecchia.split('u')[0])+1)
   id = riga + 'u' + co
   if fuori(id)
     riga = parseInt(riga - parseInt(altezzaColonna(co,parseInt(riga-1))))
   id = riga + 'u' + co
   return id

gnam = (testa) ->
   ris = false
   ris = true if checkFood testa
   eat() if ris is true
   return ris

eat = ->
   rr = getRandomInt(1,31)
   rc = getRandomInt(1,31)
   color('red',rr+'u'+rc)
   aumentaPunti(10)

aumentaPunti= (q) ->
   punti = parseInt(punti) + parseInt(q)
   $('#actualRecord').text(punti)

goon = (nuovatesta) ->
   serpenteNew = []
   dim = serpente.length;
   serpenteNew[0] = nuovatesta
   ro = [1..dim-1]
   for i in ro
      serpenteNew[i]=serpente[i-1]
   serpenteNew[dim] = serpente[dim-1] if gnam nuovatesta
   ri = [0..serpenteNew.length-1]
   for i in ri
      serpente[i]=serpenteNew[i]
   return serpente

forward = ->
   vecchiaTesta = serpente[0]
   nuovatesta = forwardRight vecchiaTesta if direzione=='right'
   nuovatesta = forwardLeft vecchiaTesta if direzione=='left'
   nuovatesta = forwardUp vecchiaTesta if direzione=='up'
   nuovatesta = forwardDown vecchiaTesta if direzione=='down'
   clean serpente[serpente.length-1]
   serpente = goon(nuovatesta) if checkAlive nuovatesta
   draw()

clean = (id) ->
   color('yellow',id)

draw = ->
   rs = [0..serpente.length]
   for i in rs
      color('black',serpente[i])
      round(serpente[i])