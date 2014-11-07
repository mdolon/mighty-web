$ ->
  analytics =
    track: (name, properties = "") =>
      mixpanel.track name, properties
      ga('send', 'event', 'link', 'click', name)

  $(".trackEvent").click (ev) ->
    name = $(@).data("name")
    properties = $(@).data("properties")
    analytics.track(name, properties)
