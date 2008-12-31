class AddRatingAverageToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :rating_average, :decimal, :default => 0
  end

  def self.down
    remove_column :videos, :rating_average
  end
end
