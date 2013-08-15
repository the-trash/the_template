class @Helper
  @viewport_height = ->
    wh = $(window).height()
    hh = $('.header').height()
    fh = $('.footer').height()
    wh - hh - fh

  @viewport_width = ->
    $(window).width() - $('.sidebar').width()

@scrollbar_toggle = ->
  $('.content_holder').css
    height: Helper.viewport_height()

@goo_map_resize = ->
  $('.map').css
    height: Helper.viewport_height()
    width:  Helper.viewport_width()

@resize_basic_blocks = ->
  goo_map_resize()
  scrollbar_toggle()

$ ->
  do resize_basic_blocks
  $(window).resize -> do resize_basic_blocks

  $('.search_form').on 'click', '#find_it', ->
    input = $ '#address'

    GMap.find.geocode
      address: input.val()
    , (results, status) ->
      if status is google.maps.GeocoderStatus.OK
        first_place = results[0]

        if first_place
          position = first_place.geometry.location

          GMap.clean()
          GMap.map.setCenter position
          GMap.build_marker_group(position)

          # GMap.find.geocode({})

      else
        log "Geocode was not successful for the following reason: #{status}"