movable = 'null'
moving = false
offsetl = 0
offsett = 0

window.drag = (id) ->
  if moving == false
    moving=true
  else
    moving =false
  movable = id
  offsetl = event.pageX
  offsett = event.pageY
  $('#'+id).css('position','absolute')

window.omm = ->
  x= event.pageX
  y= event.pageY
  id = movable
  if moving
    $('#'+id).css('margin-left', x-offsetl)
    $('#'+id).css('margin-top', y-offsett)