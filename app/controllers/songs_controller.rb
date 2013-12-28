# coding: utf-8
class SongsController < ApplicationController
  def search
    if params['clear']=="true"
      @result = []
    else
      series_id = params['series']
      query     = params['query']
      songs = Song.search(query, params['searchpos']=='included')
      songs = songs.where(series_id: series_id) unless params['series'] == 'empty'
      song_ids = songs.map { |s| s.id }

      { Character => 'character',
        Vocalist  => 'vocalist',
        Composer  => 'composer',
        Writer    => 'writer',
        Arranger  => 'arranger',
      }.each do |clazz, str|
        value = params[str]
        next if value.nil? || value == 'empty'
        ids = []
        obj = clazz.where(id: value).first
        obj.send((str+'_links').intern).each do |link|
          next unless link.song
          ids << link.song.id
        end
        # 共通部分のみ取得
        song_ids &= ids
      end
      @result = Song.where(id: song_ids)
    end
    if request.xhr?
      part = is_mobile ? 'songs/song_table_m' : 'songs/song_table'
      html = render_to_string partial: part
      render json: { html: html }
    end
  end

  def is_mobile
    request.headers['referer'].include?('mobile')
  end
end
