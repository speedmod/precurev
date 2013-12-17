json.array!(@songs) do |song|
  json.extract! song, 
  json.url song_url(song, format: :json)
end