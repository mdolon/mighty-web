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
    $(".leadgen .slide-strip").css("width", slide_width*num_slides)
    $(".leadgen .slide-strip").css("left", -offset)

  sliderNext = () =>
    current_slide = $(".slide.current")
    next_slide = current_slide.next()
    if next_slide.length
      current_slide.removeClass("current")
      next_slide.addClass("current")
      slide_width = $(".leadgen .slide-wrap").width()
      $(".leadgen .slide-strip").animate
        left: "+=" + (-slide_width)
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
      sliderNext()
    , 250
    ev.preventDefault()

  $("#find-trainer-form").submit (ev) =>
    sliderNext()
    ev.preventDefault()
