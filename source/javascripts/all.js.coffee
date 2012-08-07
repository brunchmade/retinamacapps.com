//= require_tree .

deviceAgent = navigator.userAgent.toLowerCase();
agent = deviceAgent.match(/(iphone|ipod|ipad|android)/);

# Swap in mailto: for download links on mobile devices
convertoToMailto = ->
  $(".application").each ->
    url = encodeURIComponent $(this).attr "href"
    msg = encodeURIComponent $(this).attr "title"
    $(this).attr "href", "mailto:?Subject=This%20app%20looks%20killer%20on%20Retina!&Body=" + msg + "%0d%0a" + url

$(document).ready ->
  retinajs()
  convertoToMailto()

  # Handle submit click
  $("#openSubmissionModal").click (e) ->
    e.preventDefault();
    $("#submissionModal").reveal()

  # Handle digest click
  $("#openNewsletterModal").click (e) ->
    e.preventDefault();
    $("#newsletterModal").reveal()
  
  # Handle filter select event
  $("#filter").change ->
    switch $(this).val()
      when "c"
        file = "sort_cat.html"
      when "n"
        file = "sort_name.html"
      else
        file = "sort_recent.html"

    $.get "/partials/" + file, (data) ->
      $("#main-content").fadeOut 175, ->
        $(this).html(data).fadeIn 225
        retinajs(true)
        convertoToMailto()
