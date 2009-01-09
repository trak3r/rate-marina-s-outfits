class VideosController < ApplicationController
  protect_from_forgery :except => [:rate, :show, :best]
  before_filter :login_required, :only => [:rate]
  
  def rate
    @video = Video.find(params[:id])
    @video.rate(params[:stars], current_user)
    id = "ajaxful-rating-video-#{@video.id}"
    render :update do |page|
      page.replace_html id, ratings_for(@video, :static, :wrap => false)
      page.insert_html :bottom, id, "Thanks for rating!"
      page.visual_effect :highlight, id
    end
  end

  # GET /videos
  # GET /videos.xml
  def index
    respond_to do |format|
      format.html {congeal(Video.delayed.first)}
      format.js do
        @videos = Video.delayed.paginate :page => params[:page], :per_page => 4
        render :layout => false
      end
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    congeal(Video.find(params[:id]))
  end

  def best
    @videos = Video.best.all(:limit => 12)
  end

  private

  def congeal(video)
    @video =  video
    @videos = Video.delayed.paginate :page => params[:page], :per_page => 4
    respond_to do |format|
      format.html { render :template => 'videos/show' }
      format.js   { render :partial => 'videos/episode' }
    end
  end
end
