$ ->
  do initGMap

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
          bound = GMap.bound_around_point(position, 100)

          GMap.find.geocode
            latLng: position
            bounds: bound
          , (results, status) ->
            if status is google.maps.GeocoderStatus.OK
              $('.sidebar').html (results.map (item) ->
                "<p>#{item.formatted_address}</p>"
              ).join ''
      else
        log "Geocode was not successful for the following reason: #{status}"