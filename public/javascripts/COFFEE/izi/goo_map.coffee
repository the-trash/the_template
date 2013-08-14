class @GMap
  @map      = null
  @marker   = null
  @circle   = null
  @find     = null

  @on: (obj, event, fn) ->
    google.maps.event.addListener(obj, event, fn) if obj

  @clean: ->
    @marker.setMap(null) if @marker
    @circle.setMap(null) if @circle

  @build_marker: (params) ->
    @marker = new google.maps.Marker params

  @build_circle: (params) ->
    GMap.circle = new google.maps.Circle params