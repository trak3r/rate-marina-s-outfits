class VideosController < ApplicationController
  protect_from_forgery :except => [:rate, :show]
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
    @videos = Video.paginate :page => params[:page], :order => 'published_at DESC', :per_page => 12

    respond_to do |format|
      format.html # index.html.erb
      format.js   { render :layout => false }
      format.xml  { render :xml => @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js   { render :layout => false }
      format.xml  { render :xml => @video }
    end
  end
end
