# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

getParams = ->
  url = location.href
  params_string = url.split("?")[1]
  return {} unless params_string?
  param_strings = params_string.split("&");
  params = {}
  for param_string in param_strings
    param = param_string.split("=")
    params[param[0]] = param[1]
  params

$ ->
  $('#q').keyup ->
    query = $(@).val()
    params = getParams()
    $.ajax
      url: '/pod_libraries'
      data:
        q: query
        o: params['o']
      dataType: 'script'
    $('#results').hide()
    $('#loading').show()
