@initGMap = ->

  mapOptions =
    zoom:      16
    center:    new google.maps.LatLng(-34.397, 150.644)
    mapTypeId: google.maps.MapTypeId.ROADMAP

  GMap.map  = new google.maps.Map document.getElementById("map-canvas"), mapOptions
  GMap.find = new google.maps.Geocoder()

  GMap.on GMap.map, 'click', (e) ->
    GMap.clean()
    GMap.build_marker_group(e.latLng)
    
    # GMap.find.geocode
    #   latLng: e.latLng
    # , (results, status) ->
    #   log results

window.onload = ->
  script      = document.createElement("script")
  script.type = "text/javascript"
  script.src  = "https://maps.googleapis.com/maps/api/js?key=AIzaSyCRaBh6UvqVRjILPDNwpZmamTkttZ6qvWU&sensor=false&callback=initGMap"
  document.body.appendChild(script)