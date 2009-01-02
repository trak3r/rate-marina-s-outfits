class ThumbnailsController < ApplicationController
  require_role "admin"
  protect_from_forgery :except => [:assign]

  def assign
    @video = Video.find(params[:video_id])
    thumbnail = @video.thumbnails.find(params[:thumbnail_id])
    @video.thumbnail_url = thumbnail.url
    @video.save!
    render :layout => false
  end

  # GET /thumbnails
  # GET /thumbnails.xml
  def index
    @videos = Video.paginate :page => params[:page], :order => 'published_at DESC', :per_page => 4

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thumbnails }
    end
  end
end
