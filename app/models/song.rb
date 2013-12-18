# coding: utf-8
class Song < ActiveRecord::Base
  has_many :kanas
  has_many :character_links
  has_many :vocalist_links
  has_many :composer_links
  has_many :writer_links
  has_many :arranger_links
  belongs_to :series

  class << self
    def search input, flg=false
      kana_str = convert_for_search input
      songs = []
      kana_str = flg ? '%'+kana_str+'%' : kana_str+'%'
      Kana.where.like(kana: kana_str).each do |k|
        songs << k.song_id
      end
      Song.where(id: songs.uniq)
    end

    def convert_for_search input
      before = 'ァ-ン０-９Ａ-Ｚぁぃぅぇぉっヵヶゃゅょゎ'
      after  = 'ぁ-ん0-9A-Zあいうえおつかけやゆよわ'
      input.upcase.tr(before,after).scan(/[ぁ-ん0-9A-Z]/).join
    end
  end

  # linkを通じて全取得
  def get data
    send((data.to_s+"_links").intern).map { |link| link.send(data.intern) }
  end
end
