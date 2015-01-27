$(document).ready ->
  family = ($('#family').data('family-tags') || '').split('|')
  if family.length == 1 && family[0] == ''
    family = []
  $('#family').tags({
    tagData: family,
    tagSize: 'lg',
    caseInsensitive: true,
    promptText: 'Type a name (and hit enter)'
  })
  $('#family').find('input').attr('name', 'user[family]')
  $('#family').closest('form').submit ->
    familyData = $('#family').tags().getTags()
    $('#family').find('input').val(familyData.join("|"))
