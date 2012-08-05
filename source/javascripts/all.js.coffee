//= require_tree .

$(document).ready ->
  $(".app-item").mouseenter ->
    $(this).find(".tooltip").show()

  $(".app-item").mouseleave ->
    $(this).find(".tooltip").hide()