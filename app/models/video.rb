class Video < ActiveRecord::Base
  ajaxful_rateable :stars => 5

  validates_presence_of :title
  validates_presence_of :youtube_id
  validates_presence_of :embed_url
  validates_presence_of :thumbnail_url
  
  validates_uniqueness_of :youtube_id

  has_many :thumbnails

  named_scope :delayed, lambda {{:conditions => ['published_at < ?', 3.days.ago], :order => 'published_at DESC'}}

  named_scope :best, :order => 'rating_average desc'
end
