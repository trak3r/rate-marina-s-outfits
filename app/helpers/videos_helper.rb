module VideosHelper
  def link_to_remote_show(video)
    link_to_remote(
      image_tag(
        video.thumbnail_url,
        :alt => h(video.title)),
      :method=> 'get',
      :update => 'episode',
      :url => {
        :controller => 'videos',
        :action => 'show',
        :id => video.id},
      :loading => "$('video').innerHTML=$('episode_spinner').innerHTML")
  end

  def will_paginate_remote_index
    will_paginate(
      @videos,
      :renderer => 'RemoteLinkRenderer',
      :remote => {
        :url => {
          :action => 'index'},
        :update => 'videos',
        :loading => "$('videos').innerHTML=$('videos_spinner').innerHTML"})
  end
end