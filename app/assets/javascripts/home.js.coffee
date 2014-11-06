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
        if timesRun is 3
          clearInterval interval
          $(".slide-fx").remove()
          return
        slide = $("<div class='slide-fx panel'></div>")
        $(".slide-cont").append slide
        slide.animate
          top: -15
          left: -15
          right: -15
          bottom: -15
          opacity: 0
        , 300
        timesRun++
      , 200)


  slider.resetSize()
  setTimeout slider.pulse, 1000

  $(window).on 'resize', slider.resetSize

  $(".leadgen .slide.objective a.objective-link").click (ev) =>
    $(".objective-link").removeClass("active")
    $(@).addClass("active")
    name = $(@).data("name")
    value = $(@).data("value")
    $(".leadgen .slide.personalize .panel-heading span").text(name)
    setTimeout () =>
      slider.slide("next")
    , 250
    ev.preventDefault()


  $(".leadgen .slide.personalize .prev-slide").click (ev) ->
    slider.slide("prev")
    ev.preventDefault()

  $("#find-trainer-form").submit (ev) ->
    slider.slide("next")
    ev.preventDefault()

  $(".activities .label").click (ev) ->
    $(@).toggleClass("active")
    ev.preventDefault()

  $('.datepicker').datepicker()
  $("#price").slider()
  $("#price").on "slide", (slideEvt) ->
    $(".price-input").text slideEvt.value
