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
    prep_pagination
    respond_to do |format|
      format.js do
        render :layout => false
      end
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    if params[:id]
      if params[:page]
        @page = params[:page]
      else
        if session[:last_page] and 0 < session[:last_page].to_i
          @page = session[:last_page]
        end
      end
      session[:last_page] = @page
      session[:last_video] = params[:id]
      @video = Video.find(params[:id])
      prep_pagination
    else
      if session[:last_video]
        redirect_to video_path(Video.find(session[:last_video]))
      else
        redirect_to video_path(Video.delayed.first)
      end
    end
  end

  def best
    @videos = Video.best.all(:limit => 12)
  end

  private

  def prep_pagination
    if params[:page]
      @page = params[:page]
    else
      if session[:last_page] and 0 < session[:last_page].to_i
        @page = session[:last_page]
      end
    end
    session[:last_page] = @page
    @videos = Video.delayed.paginate :page => @page, :per_page => 4
  end

end
