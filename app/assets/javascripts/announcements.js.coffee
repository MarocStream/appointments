# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  _.each $('.input-group.date'), (i)->
    i = $(i).find('input')
    date = i.attr('data-date')?
    datetime = i.attr('data-datetime')?
    if date
      i.datetimepicker({format: 'MM/DD/YYYY'})
    else if datetime
      i.datetimepicker({format: 'MM/DD/YYYY HH:mm a'})
