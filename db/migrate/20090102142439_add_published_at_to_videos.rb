class AddPublishedAtToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :published_at, :datetime
  end

  def self.down
    remove_column :videos, :published_at
  end
end
