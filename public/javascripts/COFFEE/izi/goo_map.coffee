class @GMap
  @map      = null
  @marker   = null
  @circle   = null
  @find     = null

  @bound_around_point: (point, meters = 50) -> 
    meters /= 1000

    lat   = point.position.lat()
    lng   = point.position.lng()
    coord = { lat: lat, lng: lng }

    lng_corr = meters / (Math.cos(coord['lat'] * Math.PI / 180) * 111.11) / 2
    lat_corr = meters / 111.11 / 2

    swLatLng = new google.maps.LatLng(coord['lat'] - lat_corr, coord['lng'] - lng_corr)
    neLatLng = new google.maps.LatLng(coord['lat'] + lat_corr, coord['lng'] + lng_corr)

    new google.maps.LatLngBounds(swLatLng, neLatLng)

  @shift_right: (position, meters = 50) ->
    lat   = position.lat()
    lng   = position.lng()
    coord = { lat: lat, lng: lng }
    
    lng_corr = meters / (Math.cos(coord['lat'] * Math.PI / 180) * 111.11) / 2
    swLatLng = new google.maps.LatLng(coord['lat'], coord['lng'] + lng_corr)

  @shift_down: (position, meters = 50) ->
    lat   = position.lat()
    lng   = position.lng()
    coord = { lat: lat, lng: lng }

    lat_corr = meters / 111.11 / 2    
    neLatLng = new google.maps.LatLng(coord['lat'] + lat_corr, coord['lng'])

  @on: (obj, event, fn) ->
    google.maps.event.addListener(obj, event, fn) if obj

  @clean: ->
    @marker.setMap(null) if @marker
    @circle.setMap(null) if @circle

  @build_marker: (params) ->
    @marker = new google.maps.Marker params

  @build_circle: (params) ->
    GMap.circle = new google.maps.Circle params

  @build_rectangle: (params) ->
    GMap.rect = new google.maps.Rectangle params
  
  @build_marker_group: (position) ->
    GMap.build_marker
      map:      GMap.map
      position: position
      title:    'Marker'
      draggable: true

    GMap.build_circle
      map:          GMap.map
      center:       position
      strokeColor:  '#FF0000'
      fillColor:    '#FF0000'
      fillOpacity:   0.35
      radius:        50
      strokeOpacity: 0.8
      strokeWeight:  2
      draggable: true

    _position = GMap.shift_right position
    _position = GMap.shift_down  _position

    GMap.build_marker
      map:      GMap.map
      icon:     GMap.icon
      position: _position
      title:    'Drop'
      icon:     "http://cs538621.vk.me/u49225742/doc/d786e1d0b117/1376592036_Gnome-Edit-Delete-64.png"

    GMap.build_rectangle
      map:          GMap.map
      bounds:       GMap.bound_around_point(GMap.marker, 100)
      strokeColor:  '#00FF00'
      fillColor:    '#00FF00'
      fillOpacity:   0.35
      strokeOpacity: 0.8
      strokeWeight:  2
      draggable: true