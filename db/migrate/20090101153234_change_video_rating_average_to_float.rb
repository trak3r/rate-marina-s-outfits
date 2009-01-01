class ChangeVideoRatingAverageToFloat < ActiveRecord::Migration
  def self.up
    change_column :videos, :rating_average, :float, :default => 0
  end

  def self.down
    change_column :videos, :rating_average, :decimal, :default => 0
  end
end
