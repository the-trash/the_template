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
    , (data, status) ->
      if status is google.maps.GeocoderStatus.OK
        first_place = data[0]
        position    = first_place.geometry.location

        GMap.clean()

        GMap.build_marker
          map:      GMap.map
          position: position
          title:    'Marker'

        GMap.build_circle
          map:          GMap.map
          center:       position
          strokeColor:  '#FF0000'
          fillColor:    '#FF0000'
          fillOpacity:   0.35
          radius:        50
          strokeOpacity: 0.8
          strokeWeight:  2

        GMap.map.setCenter position
      else
        log "Geocode was not successful for the following reason: #{status}"