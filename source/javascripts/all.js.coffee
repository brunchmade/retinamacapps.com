//= require_tree .

$(document).ready ->
  $("#filter").change ->
    switch $(this).val()
      when "c"
        file = "sort_cat.html"
      when "n"
        file = "sort_name.html"
      else
        file = "sort_recent.html"

    $.get "/partials/" + file, (data) ->
      $("#main-content").html(data)
