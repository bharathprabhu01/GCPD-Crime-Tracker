# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('select.enhanced_filter').on 'change', ->
  $(this).parents('form').submit()

$("select option[value='Select an Option']").attr('disabled', true); 