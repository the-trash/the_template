$ ->
  $('.menu').on 'mouseenter', 'ul > li', ->
    $(".menu .submenu").hide()
    $(@).find(".submenu").show()

  $('.menu ul').on 'mouseleave', '.submenu', ->
    $(@).hide()