deviceAgent = navigator.userAgent.toLowerCase();
agent = deviceAgent.match(/(iphone|ipod|ipad|android)/);

# Swap in mailto: for download links on mobile devices
convertoToMailto = ->
  if agent
    $(".application").each ->
      url = encodeURIComponent $(this).attr "href"
      msg = encodeURIComponent $(this).attr "title"
      $(this).attr "href", "mailto:?Subject=This%20app%20looks%20killer%20on%20Retina!&Body=" + msg + "%0d%0a" + url

# Handler get request for filter
filterChange = (val) ->
  switch val
    when "c"
      file = "sort_cat.html"
    when "n"
      file = "sort_name.html"
    else
      file = "sort_recent.html"

  $.get "/partials/" + file, (data) ->
    $("#app-wrapper").fadeOut 175, ->
      $(this).html(data).fadeIn 225
      if val is 'c'
        $('#cat-list').fadeIn 225
      else
        $('#cat-list').fadeOut 175
      retinajs(true)
      convertoToMailto()

# Keyup delay
delay = (->
  timer = 0
  (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback, ms)
)()

# Handle ajax to search apps
searchApps = ->
  unless $("#searchForm").find("#search").val() is ''
    formData = $("#searchForm").serialize()
    $.ajax
      url: "/partials/search.html"
      type: "post"
      data: formData
      dataType: "html"
      success: (data) ->
        $("#app-wrapper").fadeOut 25, ->
          $(this).html(data).fadeIn 50
          retinajs(true)
          convertoToMailto()
          $(".openSubmissionModal").click (e) ->
            e.preventDefault()
            $("#submissionModal").reveal()
  else
    filterChange $("#filter").val()

$(document).ready ->
  retinajs()
  convertoToMailto()

  # Handle submit click
  $("#openSubmissionModal").click (e) ->
    e.preventDefault()
    $("#submissionModal").reveal()

  # Handle digest click
  $("#openNewsletterModal").click (e) ->
    e.preventDefault()
    $("#newsletterModal").reveal()

  # Handle colophon click
  $("#openColophonModal").click (e) ->
    e.preventDefault()
    $("#colophonModal").reveal()

  # Handle filter select event
  $("#filter").change ->
    filterChange $(this).val()

  # Handle search submit
  $("#searchForm").submit (e) ->
    searchApps()
    return false

  # Handle search keyup event
  $("#searchForm").keyup ->
    delay (->
      searchApps()
    ), 500

  # Handle clear search field event
  $("#search").on "search", (e) ->
    searchApps()

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

  $("#search").on "focus", (e) ->
    _gaq.push(["_trackEvent", "Search", "Focus"])
