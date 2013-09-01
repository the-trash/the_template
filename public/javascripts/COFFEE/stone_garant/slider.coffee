@Slider =
  in_progress: false
  container:    -> $('.slider ul')
  lis:          -> $ 'li', @container()
  slides_count: -> @lis().length
  slide_width:  -> $('.slider li').width()
  shift:        -> @container().position().left

  init: ->
    $(".slider .fwd").click =>
      unless @in_progress
        _shift = Math.abs @shift() - @slide_width()
        unless _shift >= @slide_width() * @slides_count()
          @in_progress = true
          @container().animate { left: "-=#{@slide_width()}px" }, 600, =>
            @in_progress = false
      false

    $(".slider .bck").click =>
      unless @in_progress
        if @shift() isnt 0
          @in_progress = true
          @container().animate { left: "+=#{@slide_width()}px"}, 600, =>
            @in_progress = false
      false

$ -> Slider.init()