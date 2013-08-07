@trace_mode = false

@env =
  production: false

# _log   - global log - выводит сообщения всегда
# log    - выводит сообщения везде кроме production
# trace  - выводит сообщения только если включен флаг trace_mode
# report - отправляет AJAX на сервер с сообщением

@_log   = ->
  try
    console.log.apply(console, arguments)

@log = ->
  try 
    _log.apply(console, arguments) unless env.production

@trace  = ->
  try
    _log.apply(console, arguments) if trace_mode

# @report = (args) ->
#   $.ajax 
#     type: 'POST'
#     url:  '/report'
#     data: args

# IE fix
# if $.browser.msie
#   try
#     @_log  = Function.prototype.bind.call(console.log, console)
#     @log   = ->
#     @trace = ->

#     @log   = Function.prototype.bind.call(_log, console) unless env.production()
#     @trace = Function.prototype.bind.call(_log, console) if trace_mode