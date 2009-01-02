class Thumbnail < ActiveRecord::Base
  validates_uniqueness_of :url

  belongs_to :video
end
