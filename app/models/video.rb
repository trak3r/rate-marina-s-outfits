class Video < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :youtube_id
  validates_presence_of :embed_url
  validates_presence_of :thumbnail_url
  
  validates_uniqueness_of :youtube_id
end
