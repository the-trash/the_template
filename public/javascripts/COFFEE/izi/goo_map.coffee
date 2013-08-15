class @GMap
  @marker  = {}
  @map     = null
  @circle  = null
  @bound   = null
  @find    = null

  # pinch of magick
  @bound_around_point: (position, meters = 50) -> 
    meters /= 1000

    lat   = position.lat()
    lng   = position.lng()
    coord = { lat: lat, lng: lng }

    lng_corr = meters / (Math.cos(coord['lat'] * Math.PI / 180) * 111.11) / 2
    lat_corr = meters / 111.11 / 2

    swLatLng = new google.maps.LatLng(coord['lat'] - lat_corr, coord['lng'] - lng_corr)
    neLatLng = new google.maps.LatLng(coord['lat'] + lat_corr, coord['lng'] + lng_corr)

    new google.maps.LatLngBounds(swLatLng, neLatLng)

  @shift_x: (position, meters = 50) ->
    meters /= 1000

    coord =
      lat: position.lat()
      lng: position.lng()
    
    lng_corr = meters / (Math.cos(coord['lat'] * Math.PI / 180) * 111.11) / 2
    swLatLng = new google.maps.LatLng(coord['lat'], coord['lng'] + lng_corr)

  @shift_y: (position, meters = 50) ->
    meters /= 1000

    coord =
      lat: position.lat()
      lng: position.lng()

    lat_corr = meters / 111.11 / 2 
    new google.maps.LatLng(coord['lat'] + lat_corr, coord['lng'])

  # Shortcats
  @new_marker:    (params) -> new google.maps.Marker    params
  @new_circle:    (params) -> new google.maps.Circle    params
  @new_rectangle: (params) -> new google.maps.Rectangle params

  @on: (obj, event, fn) -> google.maps.event.addListener(obj, event, fn) if obj

  # Build Objects
  @build_marker: (params) -> @marker.marker = @new_marker    params
  @build_bucket: (params) -> @marker.bucket = @new_marker    params
  @build_circle: (params) -> @circle        = @new_circle    params
  @build_bound:  (params) -> @bound         = @new_rectangle params

  # Clean up
  @clean: ->
    @marker.marker.setMap(null) if @marker.marker
    @marker.bucket.setMap(null) if @marker.bucket
    @circle.setMap(null)        if @circle
    @bound.setMap(null)         if @bound
    $('.sidebar').empty()

  @marker_group_move = (position) ->
    @bound.setBounds @bound_around_point(@marker.marker.position, 100)
    @marker.marker.setPosition(position)
    @circle.setCenter(position)

    _position = @shift_x position,   100
    _position = @shift_y _position, -110
    @marker.bucket.setPosition _position

  @build_marker_group: (position) ->
    @build_marker
      map:      @map
      position: position
      title:    'Marker'
      draggable: true

    @build_circle
      map:          @map
      center:       position
      strokeColor:  '#FF0000'
      fillColor:    '#FF0000'
      fillOpacity:   0.35
      radius:        50
      strokeOpacity: 0.8
      strokeWeight:  2
      draggable: true

    _position = @shift_x position,   100
    _position = @shift_y _position, -110

    @build_bucket
      map:      @map
      icon:     @icon
      position: _position
      title:    'Drop'
      icon:     "http://cs538402.vk.me/u49225742/doc/2dea32b4d5eb/trash.png"

    @build_bound
      map:          @map
      bounds:       @bound_around_point(@marker.marker.position, 100)
      strokeColor:  '#00FF00'
      fillColor:    '#00FF00'
      fillOpacity:   0.35
      strokeOpacity: 0.8
      strokeWeight:  2
      visible: false
      draggable: true

    @init_marker_group_behaviour()

  @init_marker_group_behaviour = ->
    @on @marker.marker, 'drag', (e) =>
      position = e.latLng
      @marker_group_move(position)

    @on @circle, 'drag', (e) =>
      position = e.latLng
      @marker_group_move(position)

    @on @marker.bucket, 'click', (e) => do @clean

    @on @bound, 'drag', (e) =>
      position = e.latLng
      @marker_group_move(position)