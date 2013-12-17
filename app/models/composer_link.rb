class ComposerLink < ActiveRecord::Base
  belongs_to :song
  belongs_to :composer
end
