namespace :dummy do
  desc 'Create dummy User accounts'
  task :users => :environment do
    raise "Don't you want to be doing this in development!?" unless 'development' == RAILS_ENV
    (1..10).to_a.each do
      user = User.new
      user.login = "random_#{rand(999999)}"
      user.password = 'random'
      user.password_confirmation = user.password
      user.email = "#{user.login}@random.com"
      user.register!
      user.activate!
    end
  end

  desc 'Create dummy Ratings for Videos'
  task :ratings => :environment do
    raise "Don't you want to be doing this in development!?" unless 'development' == RAILS_ENV
    users = User.all
    videos = Video.all
    users.each do |user|
      videos.each do |video|
        video.rate(1+rand(5),user)
      end
    end
  end
end