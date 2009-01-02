class VideosController < ApplicationController
  require_role "admin", :for_all_except => [:index, :show, :rate]
  protect_from_forgery :except => [:rate, :thumbnail]

  def thumbnail
    @video = Video.find(params[:video_id])
    thumbnail = @video.thumbnails.find(params[:thumbnail_id])
    @video.thumbnail_url = thumbnail.url
    @video.save!
    render :layout => false
  end
  
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
    @videos = Video.paginate :page => params[:page], :per_page => 15

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.xml
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.xml
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.xml
  def create
    @video = Video.new(params[:video])

    respond_to do |format|
      if @video.save
        flash[:notice] = 'Video was successfully created.'
        format.html { redirect_to(@video) }
        format.xml  { render :xml => @video, :status => :created, :location => @video }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videos/1
  # PUT /videos/1.xml
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        flash[:notice] = 'Video was successfully updated.'
        format.html { redirect_to(@video) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.xml
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to(videos_url) }
      format.xml  { head :ok }
    end
  end
end
