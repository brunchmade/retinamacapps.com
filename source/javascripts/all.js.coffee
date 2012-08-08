//= require_tree .

deviceAgent = navigator.userAgent.toLowerCase();
agent = deviceAgent.match(/(iphone|ipod|ipad|android)/);

# Swap in mailto: for download links on mobile devices
convertoToMailto = ->
  if agent
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

  # Handle colophon click
  $("#openColophonModal").click (e) ->
    e.preventDefault();
    $("#colophonModal").reveal()
  
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

  # GA Event Tracking
  $(".application").on "click", (e) ->
    _gaq.push(["_trackEvent", "Application Icon", "Download", $(this).attr "title"])

  $(".application-name").on "click", (e) ->
    _gaq.push(["_trackEvent", "Application Name", "Download", $(this).attr "title"])

  $(".developer").on "click", (e) ->
    _gaq.push(["_trackEvent", "Developer Name", "Visit", $(this).attr "title"])

  $("#main-nav a").on "click", (e) ->
    _gaq.push(["_trackEvent", "Main Nav", "Click", $(this).attr "title"])

  $("#logo").on "click", (e) ->
    _gaq.push(["_trackEvent", "Main Nav", "Click", $(this).attr "title"])

  $("#openColophonModal").on "click", (e) ->
    _gaq.push(["_trackEvent", "Main Nav", "Click", $(this).attr "title"])

  $(".creators a").on "click", (e) ->
    _gaq.push(["_trackEvent", "Creators", "Visit", $(this).attr "title"])

  $("#filter").on "change", (e) ->
    _gaq.push(["_trackEvent", "Filter", "Change", $(this).val()])
