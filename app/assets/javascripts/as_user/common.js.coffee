po = (obj,property,func) ->
  str = ""
  for prop of obj
    if typeof(obj[prop]) != 'function'
      if property != false
        str += prop + ":" + obj[prop] + "\n"
      else if func != false
        str += prop + ":" + typeof(obj[prop]) + "\n"
  str

$(document).ready ->
  $(".drop-down-menu s")
    .bind "click", (event,ui) ->
      $(".drop-down-menubox").show()

  $(".message-box .close").bind "click", () ->
    $(this).parent().remove()

