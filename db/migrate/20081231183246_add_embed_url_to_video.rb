class AddEmbedUrlToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :embed_url, :string
  end

  def self.down
    remove_column :videos, :embed_url
  end
end
