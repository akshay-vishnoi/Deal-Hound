# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#add_cat').click ->
    $('#add').show()
    $(this).parent().hide()
$ ->
  a = $('#slideshow').children()
  a.hide()
  a.first().fadeIn()
  
  
al = () ->
  console.log("hhe")


