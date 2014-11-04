//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree ./vendor
//= require_tree .

$ ->
  $(".typed").typed
    strings: [
      "Photography"
      "Acting"
      "Fitness"
      "Vegan Cooking"
      "Web Design"
      "Playing Guitar"
      "Public Speaking"
    ]
    typeSpeed: 50
    backSpeed: 25
    startDelay: 300
    backDelay: 2000
    loop: true
