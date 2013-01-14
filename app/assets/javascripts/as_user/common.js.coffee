$(document).ready ->
  $(".drop-down-menu s")
    .bind "click", (event,ui) ->
      $(".drop-down-menubox").show()
