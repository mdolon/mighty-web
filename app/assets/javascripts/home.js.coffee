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
    $(".leadgen .slide").css("width", slide_width).show()
    $(".leadgen .slide-strip").css("width", slide_width*num_slides)
    console.log('setting')

  sliderNext = () =>
    slide_width = $(".leadgen .slide-wrap").width()
    $(".leadgen .slide-strip").animate
      left: -slide_width
    , 700    

  sliderResetSize()

  $(window).on 'resize', sliderResetSize

  $(".leadgen .objective-link").bind "click", (ev) =>
    sliderNext()
    ev.preventDefault()
