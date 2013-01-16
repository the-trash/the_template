@point = -> $ '.point'

@sec_to_ms = (n) -> n * 1000
@min_to_ms = (n) -> n * 60 * 1000

@centered_on = (block, obj) ->  
  bh = block.height()
  bw = block.width()
  oh = obj.height()
  ow = obj.width()

  obj.css
    top:  bh/2 - oh/2
    left: bw/2 - ow/2

@move_left = (obj, distance, secs) ->
  obj.animate
    left: "+=#{distance}"
  , sec_to_ms(secs)

@move_right = (obj, distance, secs) ->
  obj.animate
    left: "-=#{distance}"
  , sec_to_ms(secs)

@move_up = (obj, distance, secs) ->
  obj.animate
    top: "+=#{distance}"
  , sec_to_ms(secs)

@move_down = (obj, distance, secs) ->
  obj.animate
    top: "-=#{distance}"
  , sec_to_ms(secs)

@move_diagonal = (obj, x, y, secs) ->
  obj.animate
    left: x
    top:  y
  , sec_to_ms(secs)

@polar_x_y = (r = 100, deg = 0, x0 = 0, y0 = 0) ->
  x = r * Math.cos(deg)
  y = r * Math.sin(deg)
  [x + x0, y + y0]

@rotate_on_clock = (obj, x0, y0, r) ->
  deg = 0
  setInterval ->
    deg -= .01
    [x, y] = polar_x_y(r, deg, x0, y0)
    obj.animate 
      left: x
      top:  y
    , .0001
  , sec_to_ms(.1)

$ ->
  _point = point()

  win        = $ document
  win_width  = win.width()  - 40
  win_height = win.height() - 40

  start = Date.now()

  invoke (data, callback) ->
    log data
    setTimeout ->
      callback(null, '1')
    , 3000
  .and (data, callback) ->
    log data
    setTimeout ->
      callback(null, '2')
    , 1000
  .then (data, callback) ->
    log data
    setTimeout ->
      callback(null, '3')
    , 3000
  .rescue (err) ->
    log 'error: ' + err
  .end 'initial', (data) ->
    log data
    console.log 'Sequence execution took: ' + (Date.now() - start)




  # centered_on(win, _point)
  # move_left(_point, 400 , 1)
  # rotate_on_clock(_point, win_width/2, win_height/2, 400)
  

  # # left/right
  # move_left _point, win_width/2 , .5

  # for i in [1..5]
  #   t = 1
  #   move_right _point, win_width, t
  #   move_left  _point, win_width, t

  # # to center
  # move_right _point, win_width/2 , .5

  # # up/down
  # move_up _point, win_height/2 , .5

  # for i in [1..5]
  #   t = .5
  #   move_down _point, win_height, t
  #   move_up   _point, win_height, t

  # # to center
  # move_down _point, win_height/2 , .5

  # # diagonal left:top/right:bottom
  # move_diagonal _point, 0, 0, .5

  # for i in [1..5]
  #   t = 1
  #   move_diagonal _point, win_width, win_height, t
  #   move_diagonal _point, 0, 0, t

  # # to center
  # move_diagonal _point, win_width/2, win_height/2, .5

  # # diagonal left:bottom/right:top
  # move_diagonal _point, 0, win_height, .5

  # for i in [1..5]
  #   t = 1
  #   move_diagonal _point, win_width, 0, t
  #   move_diagonal _point, 0, win_height, t

  # # to center
  # move_diagonal _point, win_width/2, win_height/2, .5