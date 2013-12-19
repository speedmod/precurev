clear_all = ->
  tokens = $('meta[name=csrf-token]').attr('content')
  $.ajax
    url: '/songs/search?clear=true'
    type: 'post'
    dataType: 'json'
    beforeSend: (request) ->
      request.setRequestHeader('X-CSRF-Token', tokens)
    success: (data) ->
      $('#song_table').html(data.html)
search_songs = ->
  tokens = $('meta[name=csrf-token]').attr('content')
  request = new XMLHttpRequest()
  query     = $('#song_query [name=query]').val()
  series    = $('#song_query [name=series]').val()
  composer  = $('#song_query [name=composer]').val()
  writer    = $('#song_query [name=writer]').val()
  arranger  = $('#song_query [name=arranger]').val()
  vocalist  = $('#song_query [name=vocalist]').val()
  character = $('#song_query [name=character]').val()
  searchpos = $('#song_query [name=searchpos]:checked').val()
  $.ajax
    url: '/songs/search'
    type: 'post'
    data: "query=#{query}&series=#{series}&composer=#{composer}&writer=#{writer}&arranger=#{arranger}&vocalist=#{vocalist}&character=#{character}&searchpos=#{searchpos}"
    dataType: 'json'
    beforeSend: (request) ->
      request.setRequestHeader('X-CSRF-Token', tokens)
    success: (data) ->
      $('#song_table').html(data.html)
$ ->
  $('#query').bind 'textchange', search_songs
  $('#resetbtn').click clear_all
  $('.fields').change search_songs
  # Ctrl-d：リセットボタン押下
  $(document).keydown (e)->
    if e.ctrlKey==true && e.which==68
      $('#resetbtn').eq(0).click()
  # Ctrl-u：プルダウンの選択解除＆再検索
  $('select').keydown (e) ->
    if e.ctrlKey==true && e.which==85
      $(this).val('empty')
      search_songs()
  # Enterキーによるsubmit抑制
  $('#query').keypress (e) -> e.which != 13
