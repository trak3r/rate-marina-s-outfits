class Video < ActiveRecord::Base
  validates_uniqueness_of :youtube_id
end
