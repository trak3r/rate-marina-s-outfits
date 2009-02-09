module VideosHelper
  def linked_thumbnail(video)
    link_to(image_tag(video.thumbnail_url, :alt => h(video.title)), video_path(video))
  end
end