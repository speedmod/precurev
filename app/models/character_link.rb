class CharacterLink < ActiveRecord::Base
  belongs_to :song
  belongs_to :character
end
