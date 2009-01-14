class VideosController < ApplicationController
  protect_from_forgery :except => [:rate, :show, :best]
  before_filter :login_required, :only => [:rate]
  
  def rate
    @video = Video.find(params[:id])
    @video.rate(params[:stars], current_user)
    id = "ajaxful-rating-video-#{@video.id}"
    render :update do |page|
      page.replace_html id, ratings_for(@video, current_user)
      page.insert_html :bottom, id, "Thanks for rating!"
      page.visual_effect :highlight, id
    end
  end

  # GET /videos
  # GET /videos.xml
  def index
    if params[:page]
      @page = params[:page]
    else
      if session[:last_page] and 0 < session[:last_page].to_i
        @page = session[:last_page]
      end
    end
    session[:last_page] = @page
    respond_to do |format|
      format.html do
        if session[:last_video] and 0 < session[:last_video].to_i
          video = Video.find(session[:last_video])
        else
          video = Video.delayed.first
        end
        congeal(video)
      end
      format.js do
        @videos = Video.delayed.paginate :page => @page, :per_page => 4
        render :layout => false
      end
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    session[:last_video] = params[:id]
    congeal(Video.find(params[:id]))
  end

  def best
    @videos = Video.best.all(:limit => 12)
  end

  private

  def congeal(video)
    @video = video
    @videos = Video.delayed.paginate :page => @page, :per_page => 4
    respond_to do |format|
      format.html { render :template => 'videos/show' }
      format.js   { render :partial => 'videos/episode' }
    end
  end
end
