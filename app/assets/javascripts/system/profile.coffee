# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

this.initMap = () ->
  $ = jQuery

  lat = $('input[data-name="lat"]')
  lng = $('input[data-name="lng"]')

  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: parseFloat($(lat).attr('value')), lng: parseFloat($(lng).attr('value'))},
    zoom: 12
  });