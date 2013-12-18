# -*- coding: utf-8 -*-
class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def search_old
    @result = Song.search(params["query"])
    html = render_to_string partial: "songs/song_table"
    render json: { html: html }
  end

    #render json: { result: @result.first.name }
  #   raise params.inspect #debug
  #   @result = Song.all
  #   if params["query"].strip.length > 0
  #     # 存在してたら@result上書き
  #     @result = Song.search(params["query"])
  #   end

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
          ids << link.song.id
        end
        # 共通部分のみ取得
        song_ids &= ids
      end

      @result = Song.where(id: song_ids)
    end
    if request.xhr?
      html = render_to_string partial: "songs/song_table"
      render json: { html: html }
    end
  end

  #   tmp = []
  #   unless params["series"] == "empty"
  #     Song.where(series_id: params["series"].to_i).each do |s|
  #       tmp << s
  #     end
  #   end
  #   # 共通部分のみ取得
  #   @result &= tmp

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    # @song = Song.new(song_params)

    # respond_to do |format|
    #   if @song.save
    #     format.html { redirect_to @song, notice: 'Song was successfully created.' }
    #     format.json { render action: 'show', status: :created, location: @song }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @song.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    # respond_to do |format|
    #   if @song.update(song_params)
    #     format.html { redirect_to @song, notice: 'Song was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @song.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    # @song.destroy
    # respond_to do |format|
    #   format.html { redirect_to songs_url }
    #   format.json { head :no_content }
    # end
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_song
  #     @song = Song.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def song_params
  #     params[:song]
  #   end
end
