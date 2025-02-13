# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # $(".typed").typed
  #   strings: [
  #     "Personal Trainer"
  #     "Fitness Coach"
  #     "Health Expert"
  #     "Nutritionist"
  #   ]
  #   typeSpeed: 50
  #   backSpeed: 25
  #   startDelay: 300
  #   backDelay: 2000
  #   loop: true

  num_slides = $(".slide").length

  slider =
    resetSize: () =>
      slide_width = $(".leadgen .slide-wrap").width()
      current_slide = $(".slide.current")
      position = $(".slide").index(current_slide) + 1
      offset = (position*slide_width)-slide_width
      $(".leadgen .slide").css("width", slide_width).show()
      $(".leadgen .slide-wrap").css("height", current_slide.height())
      $(".leadgen .slide-strip").css("width", slide_width*num_slides)
      $(".leadgen .slide-strip").css("left", -offset)

    slide: (action) => 
      current_slide = $(".slide.current")
      target_slide = if action == "next" then current_slide.next() else current_slide.prev()
      if target_slide.length
        current_slide.removeClass("current")
        target_slide.addClass("current")
        slide_width = $(".leadgen .slide-wrap").width()
        $(".leadgen .slide-strip").animate
          left: "+=" + (if action == "next" then -slide_width else slide_width)
        , 500
        $(".leadgen .slide-wrap").animate
          height: target_slide.height()
        , 500

    pulse: () ->
      timesRun = 0
      interval = setInterval(->
        if timesRun is 2
          clearInterval interval
          $(".slide-fx").remove()
          return
        slide = $("<div class='slide-fx panel'></div>")
        $(".slider-cont").append slide
        slide.animate
          top: -15
          left: -15
          right: -15
          bottom: -15
          opacity: 0
        , 300
        timesRun++
      , 200)

  setActivities = () =>
    activities_list = []
    $(".activities .label").each (index, obj) =>
      if $(obj).hasClass("active")
        activities_list.push($(obj).text())
    $("input#activities").val(activities_list.join(', '))

  form_warning = (message) ->
    $(".form-alerts").html "<div class=\"alert alert-danger alert-dismissable\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button><span>" + message + "</span></div>"
    slider.resetSize()
    return

  slider.resetSize()
  setTimeout slider.pulse, 1000
  interval2 = setInterval slider.pulse, 8000

  $(window).on 'resize', slider.resetSize

  $(".leadgen .slide.objective a.objective-link").click (ev) ->
    clearInterval interval2
    $(".objective-link").removeClass("active")
    $(@).addClass("active")
    name = $(@).data("name")
    value = $(@).data("value")
    $("input#objective").val(value)
    $(".leadgen .slide.personalize .panel-heading span").text(name)
    setTimeout () =>
      slider.slide("next")
    , 250
    ev.preventDefault()

  $(".leadgen .slide.personalize .prev-slide").click (ev) ->
    slider.slide("prev")
    ev.preventDefault()

  $(".activities .label").click (ev) ->
    $(@).toggleClass("active")
    setActivities()
    ev.preventDefault()

  datepicker = $('.datepicker').datepicker()
  datepicker.on("changeDate", (ev) ->
    datepicker.datepicker("hide")
    return
  )

  $("#pricepoint").slider()
  $("#pricepoint").on "slide", (slideEvt) ->
    $(".price-input").text slideEvt.value


  $("#find-trainer-form").submit (ev) ->
    if $("#email").val() == "" or $("#activities").val() == ""
      form_warning("Please select at least one activity.")
      ev.preventDefault
      return false
    if $("#location").val() == ""
      form_warning("Please select a neighborhood.")
      ev.preventDefault
      return false
    data =
      lead:
        name: $("#name").val()
        email: $("#email").val()
        activities: $("#activities").val()
        objective: $("#objective").val()
        location: $("#location").val()
        startdate: $("#startdate").val()
    $.ajax
      type: "POST"
      dataType: "json"
      data: data
      url: "/leads"
      success: (data, textStatus, jqXHR) =>
        slider.slide("next")
        window._fbq = window._fbq or []
        window._fbq.push [
          "track"
          "6019441127678"
          {
            value: "0.01"
            currency: "USD"
          }
        ]
        if $(window).scrollTop() > $("#find-trainer-form").offset().top
          $("html,body").animate
            scrollTop: 80
          , 500
      error: (a, b, c) =>
        form_warning("Uh oh, something went wrong. Please make sure all of the form fields are filled out!")
        slider.resetSize()

    return false

  $(".scroll-link").click ->
    if location.pathname.replace(/^\//, "") is @pathname.replace(/^\//, "") and location.hostname is @hostname
      target = $(@hash)
      target = (if target.length then target else $("[name=" + @hash.slice(1) + "]"))
      if target.length
        $("html,body").animate
          scrollTop: target.offset().top
        , 1000
        false
