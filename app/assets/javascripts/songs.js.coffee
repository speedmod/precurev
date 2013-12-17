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
  $.ajax
    url: '/songs/search'
    type: 'post'
    data: "query=#{query}&series=#{series}&composer=#{composer}&writer=#{writer}&arranger=#{arranger}&vocalist=#{vocalist}&character=#{character}"
    dataType: 'json'
    beforeSend: (request) ->
      request.setRequestHeader('X-CSRF-Token', tokens)
    success: (data) ->
      $('#song_table').html(data.html)
$ ->
  # 動くけど、結局自動補完ツール
  # availableTags = ["あいうえお",  "あかさたな",  "Asp",  "BASIC",  "C"]
  # $("#inputbox").autocomplete(source: availableTags)
    # # 英語の入力ならまだしも、日本語の入力時にうまくいかない。
  #$('#query').bind 'textchange', (event, previousText)->
  $('#query').bind 'textchange', search_songs
  $('.fields').change search_songs

    # 結局この値($(this).val())を使って検索すればいいだけ。
    #$('#outputbox').val($(this).val)
  # $('#outputbox').change ->
  #   alert(previousText)
        # alert('Hello')
  # ダイアログをキーボードで閉じた時にまで発火。うざい。
  # $('#inputbox').keyup ->
  #   alert('Hello')
  # フォーカスが変わった時に発火
  # $('#inputbox').change ->
  #   alert('Hello')
#   $('#outputbox').text previousText + $(this).val()
