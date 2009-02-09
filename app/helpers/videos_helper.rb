module VideosHelper
  def linked_thumbnail(video)
    link_to(image_tag(video.thumbnail_url, :alt => h(video.title)), video_path(video))
  end

  def will_paginate_remote_index
    will_paginate(
      @videos,
      :renderer => 'RemoteLinkRenderer',
      :remote => {
        :url => {
          :action => 'index'},
        :update => 'videos',
        :loading => "$('videos').innerHTML=$('ajax_spinner').innerHTML"})
  end
end