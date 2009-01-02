namespace :videos do
  desc 'Load *all* the videos from YouTube into the database'
  task :harvest => :environment do
    client = YouTubeG::Client.new
    page = 1
    empty = false
    until empty do
      puts "Page ##{page}"
      response = client.videos_by(:user => 'hotforwords', :page => page)
      process(response)
      page += 1
      empty = response.videos.empty?
    end
  end

  private

  def process(response)
    response.videos.each do |episode|
      video = Video.find_by_youtube_id(episode.video_id) || Video.new
      video.title = episode.title
      video.youtube_id = episode.video_id
      video.published_at = episode.published_at
      video.embed_url = episode.media_content.first.url
      video.thumbnail_url = episode.thumbnails.first.url unless video.thumbnail_url
      video.save!
      puts "#{video.title}"
      episode.thumbnails.each do |image|
        thumbnail = Thumbnail.find_by_url(image.url)
        unless thumbnail
          thumbnail = Thumbnail.new(:url => image.url)
          video.thumbnails << thumbnail
        end
      end
    end
  end
end