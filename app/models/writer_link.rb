class WriterLink < ActiveRecord::Base
  belongs_to :song
  belongs_to :writer
end
