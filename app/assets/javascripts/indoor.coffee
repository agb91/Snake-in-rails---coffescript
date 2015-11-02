$('#nascondi').hide();
serpente = ['4-7','4-6','4-5','4-4']
time = 400
direzione = 'right'
morto = 0

window.addEventListener "keydown", (e) => keyb e.keyCode

keyb = (i) ->
   upkey() if i==38
   downkey() if i==40
   rightkey() if i==39
   leftkey() if i==37

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

getColor = (id) ->
  cid = '#'+id
  $(cid).css('background-color')

nero = getColor '4-7'

setLabirinth = (l)->
  bars = parseInt($('#barriers').text().trim())
  for i in [0..bars-1]
     livello = $('#livello'+i).text().trim()
     if parseInt(l)==parseInt(livello)
        xstart = $('#xstart'+i).text().trim()
        ystart = $('#ystart'+i).text().trim()
        length = $('#length'+i).text().trim()
        direction = $('#direction'+i).text().trim()
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
     id = parseInt(parseInt(ystart)+i) + "-" + xstart
     os2[i]= id
  return os2

getLabVector1 = (xstart, ystart, length) ->
  os1 = []
  for i in [0..length]
     id = ystart + "-" + parseInt(parseInt(xstart)+i)
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
    console.log ris

window.avvia = (l) ->
  labs = readJSON(l).level
  draw()
  setLabirinth(l)
  food()
  setInterval(forward, time)

getRandomInt = (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

food = ->
  rr = getRandomInt(1,31)
  rc = getRandomInt(1,31)
  color('red',rr+'-'+rc)

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
  alert 'morte' if alive is false && morto == 0
  morto = 1 if alive is false
  return alive

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

forwardRight = (vecchia) ->
   colonna = parseInt(parseInt(vecchia.split('-')[1])+1) %% 33
   id = vecchia.split('-')[0] + '-' + colonna

forwardLeft = (vecchia) ->
   colonna = parseInt(parseInt(vecchia.split('-')[1])-1)
   colonna = 32 if colonna == -1
   id = vecchia.split('-')[0] + '-' + colonna

forwardUp = (vecchia) ->
   riga = parseInt(parseInt(vecchia.split('-')[0])-1)
   riga = 32 if riga == -1
   id = riga + '-' + vecchia.split('-')[1]

forwardDown = (vecchia) ->
   riga = parseInt(parseInt(vecchia.split('-')[0])+1) %% 33
   id =  riga + '-' + vecchia.split('-')[1]

gnam = (testa) ->
   ris = false
   ris = true if checkFood testa
   eat() if ris is true
   return ris

eat = ->
   rr = getRandomInt(1,31)
   rc = getRandomInt(1,31)
   color('red',rr+'-'+rc)

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