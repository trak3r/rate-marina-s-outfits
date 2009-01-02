namespace :videos do
  desc 'Load the latest videos from YouTube into the database'
  task :latest => :environment do
    client = YouTubeG::Client.new
    response = client.videos_by(:user => 'hotforwords')
    response.videos.each do |episode|
      video = Video.find_by_youtube_id(episode.video_id)
      unless video
        video = Video.new
        video.title = episode.title
        video.youtube_id = episode.video_id
        video.thumbnail_url = episode.thumbnails.first.url
        video.embed_url = episode.media_content.first.url
        video.save!
      end
      first = true
      episode.thumbnails.each do |image|
        thumbnail = Thumbnail.find_by_url(image.url)
        unless thumbnail
          thumbnail = Thumbnail.new(:url => image.url)
          video.thumbnails << thumbnail
          if first
            video.thumbnail_url = thumbnail.url
            first = false
          end
        end
      end
    end
  end
end