# coding: utf-8
module SongHelper
  def artists_column writer_arr, composer_arr, arranger_arr
    writers   = writer_arr.join(',')
    composers = composer_arr.join(',')
    arrangers = arranger_arr.join(',')
    writers   = (writers.size   == 0 ? '?' : writers)
    composers = (composers.size == 0 ? '?' : composers)
    arrangers = (arrangers.size == 0 ? nil : arrangers)
    [writers, composers, arrangers].compact.join('／')
  end
end
