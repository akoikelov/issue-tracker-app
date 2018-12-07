# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

this.initMap = () ->
  $ = jQuery

  lat = $('input[data-name="lat"]')
  lng = $('input[data-name="lng"]')

  initialPlace = {lat: parseFloat($(lat).attr('value')), lng: parseFloat($(lng).attr('value'))}

  map = new google.maps.Map(document.getElementById('map'), {
    center: initialPlace,
    zoom: 12
  });

  marker = new google.maps.Marker({position: initialPlace, map: map, draggable: true});
  marker.addListener('drag', (event) ->
    $(lat).attr('value', event.latLng.lat())
    $(lng).attr('value', event.latLng.lng())
  )