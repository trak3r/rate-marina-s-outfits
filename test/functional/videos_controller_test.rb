require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should get new" do
    login_as('admin')
    get :new
    assert_response :success
  end

  test "should create video" do
    login_as('admin')
    assert_difference('Video.count') do
      post :create, :video => dummy_data
    end

    assert_redirected_to video_path(assigns(:video))
  end

  test "should show video" do
    get :show, :id => videos(:one).id
    assert_response :success
  end

  test "should get edit" do
    login_as('admin')
    get :edit, :id => videos(:one).id
    assert_response :success
  end

  test "should update video" do
    login_as('admin')
    put :update, :id => videos(:one).id, :video => dummy_data
    assert_redirected_to video_path(assigns(:video))
  end

  test "should destroy video" do
    login_as('admin')
    assert_difference('Video.count', -1) do
      delete :destroy, :id => videos(:one).id
    end

    assert_redirected_to videos_path
  end

  private

  def dummy_data
    { :title => "Functional Test Video",
      :embed_url => "http://youtube.com/test",
      :thumbnail_url => "http://youtube.com/thumbnails/test",
      :youtube_id => "SOMERANDOMGARBAGEHASHLIKESTRING"
    }
  end
end
