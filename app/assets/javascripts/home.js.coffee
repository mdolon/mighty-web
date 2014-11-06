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

  sliderResetSize = () =>
    slide_width = $(".leadgen .slide-wrap").width()
    current_slide = $(".slide.current")
    position = $(".slide").index(current_slide) + 1
    offset = (position*slide_width)-slide_width
    $(".leadgen .slide").css("width", slide_width).show()
    $(".leadgen .slide-wrap").css("height", current_slide.height())
    $(".leadgen .slide-strip").css("width", slide_width*num_slides)
    $(".leadgen .slide-strip").css("left", -offset)

  slide = (action) => 
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

  sliderResetSize()

  $(window).on 'resize', sliderResetSize

  $(".leadgen .slide.objective .objective-link").click (ev) =>
    $(".objective-link").removeClass("active")
    link = if $(ev.target).hasClass("objective-link") then $(ev.target) else $(ev.target).parents("a")
    link.addClass("active")
    name = $(link).data("name")
    value = $(link).data("value")
    $(".leadgen .slide.personalize .panel-heading span").text(name)
    setTimeout () =>
      slide("next")
    , 250
    ev.preventDefault()

  $(".leadgen .slide.personalize .prev-slide").click (ev) =>
    slide("prev")
    ev.preventDefault()

  $("#find-trainer-form").submit (ev) =>
    slide("next")
    ev.preventDefault()
