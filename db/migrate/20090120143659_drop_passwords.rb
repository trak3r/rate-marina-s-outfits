class DropPasswords < ActiveRecord::Migration
  def self.up
    drop_table :passwords 
  end

  def self.down
    create_table :passwords do |t|
      t.integer :user_id
      t.string :reset_code
      t.datetime :expiration_date
      t.timestamps
    end
  end
end
