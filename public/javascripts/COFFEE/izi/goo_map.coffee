class @GMap
  @map      = null
  @marker   = null
  @circle   = null
  @find     = null

  @create_bound_rect: ->
    x = GMap.marker.position.lat()
    y = GMap.marker.position.lng()

    swLatLng = new google.maps.LatLng(x - 0.1, y - 0.1)
    neLatLng = new google.maps.LatLng(x + 0.1, y + 0.1)

    new google.maps.LatLngBounds(swLatLng, neLatLng)

  @on: (obj, event, fn) ->
    google.maps.event.addListener(obj, event, fn) if obj

  @clean: ->
    @marker.setMap(null) if @marker
    @circle.setMap(null) if @circle

  @build_marker: (params) ->
    @marker = new google.maps.Marker params

  @build_circle: (params) ->
    GMap.circle = new google.maps.Circle params

  @build_rect: (params) ->
    GMap.rect = new google.maps.Rectangle params    

  @build_marker_pair: (position) ->
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