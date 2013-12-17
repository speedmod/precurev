class ArrangerLink < ActiveRecord::Base
  belongs_to :song
  belongs_to :arranger
end
