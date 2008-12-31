namespace :videos do
  desc 'Load the latest videos from YouTube into the database'
  task :latest => :environment do
    client = YouTubeG::Client.new
    response = client.videos_by(:user => 'hotforwords')
    response.videos.each do |episode|
      unless Video.find_by_youtube_id(episode.video_id)
        video = Video.new
        video.title = episode.title
        video.youtube_id = episode.video_id
        video.thumbnail_url = episode.thumbnails.first.url
        video.save!
      end
    end
  end
end