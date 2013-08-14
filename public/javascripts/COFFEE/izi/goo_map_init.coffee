@initGMap = ->
  mapOptions =
    zoom:      8
    center:    new google.maps.LatLng(-34.397, 150.644)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  GMap.map  = new google.maps.Map document.getElementById("map-canvas"), mapOptions
  GMap.find = new google.maps.Geocoder()

  GMap.on GMap.map, 'click', (e) ->
    GMap.clean()

    GMap.build_marker
      map:      GMap.map
      position: e.latLng
      title:    'Marker'

    GMap.build_circle
      map:          GMap.map
      center:       e.latLng
      strokeColor:  '#FF0000'
      fillColor:    '#FF0000'
      fillOpacity:   0.35
      radius:        50
      strokeOpacity: 0.8
      strokeWeight:  2

  # GMap.on GMap.marker, 'click', -> log 'Hello World!'

window.onload = ->
  script      = document.createElement("script")
  script.type = "text/javascript"
  script.src  = "https://maps.googleapis.com/maps/api/js?key=AIzaSyCRaBh6UvqVRjILPDNwpZmamTkttZ6qvWU&sensor=false&callback=initGMap"
  document.body.appendChild(script)