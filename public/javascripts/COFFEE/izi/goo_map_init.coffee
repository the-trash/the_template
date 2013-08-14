@initGMap = ->
  mapOptions =
    zoom:      8
    center:    new google.maps.LatLng(-34.397, 150.644)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  GMap.map  = new google.maps.Map document.getElementById("map-canvas"), mapOptions
  GMap.find = new google.maps.Geocoder()

  GMap.on GMap.map, 'click', (e) ->
    GMap.clean()
    GMap.build_marker_pair(e.latLng)

    GMap.build_rect
      map:          GMap.map
      bounds:       GMap.create_bound_rect()
      strokeColor:  '#00FF00'
      fillColor:    '#00FF00'
      fillOpacity:   0.35
      strokeOpacity: 0.8
      strokeWeight:  2
    
    # GMap.find.geocode
    #   latLng: e.latLng
    # , (results, status) ->
    #   log results

window.onload = ->
  script      = document.createElement("script")
  script.type = "text/javascript"
  script.src  = "https://maps.googleapis.com/maps/api/js?key=AIzaSyCRaBh6UvqVRjILPDNwpZmamTkttZ6qvWU&sensor=false&callback=initGMap"
  document.body.appendChild(script)