class RemoveRandomTestUsersAndRatings < ActiveRecord::Migration
  def self.up
    users = User.find(:all, :conditions => ['login like ?', 'random_%'])
    users.each do |user|
      ratings = Rate.find_all_by_user_id(user.id)
      ratings.each do |rating|
        rating.destroy
      end
      user.destroy
    end
  end

  def self.down
  end
end
