absolutizeSrc = (src) ->
  if /^\//.test src
    window.location.origin + src
  else if /^http/.test src
    src
  else
    path = ("" + window.location.pathname).replace /\/[^\/]+$/, "/"
    window.location.origin + path + src

fetchImages = ->
  out = []
  $("img").each ->
    $img = $(this)
    if $img.width() > 10 && $img.height() > 10
      out.push
        src: absolutizeSrc($img.attr "src")
        width: $img.width()
        height: $img.height()
  out

chrome.extension.onMessage.addListener (payload, sender, cb) ->
  if payload._action == "fetchImages"
    try
      cb [null, fetchImages()]
    catch e
      cb [e]
