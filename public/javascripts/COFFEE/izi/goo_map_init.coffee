@initGMap = ->
  GMap.find = new google.maps.Geocoder()

  mapOptions =
    zoom:      16
    center:    new google.maps.LatLng(59.939, 30.312)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  GMap.map  = new google.maps.Map document.getElementById("map-canvas"), mapOptions

  GMap.on GMap.map, 'click', (e) ->
    GMap.clean()
    GMap.build_marker_group(e.latLng)
    
    GMap.find.geocode
      latLng: e.latLng
    , (results, status) ->
      if status is google.maps.GeocoderStatus.OK
        $('.sidebar').html (results.map (item) ->
          "<p>#{item.formatted_address}</p>"
        ).join ''
      else
        log "Geocode was not successful for the following reason: #{status}"