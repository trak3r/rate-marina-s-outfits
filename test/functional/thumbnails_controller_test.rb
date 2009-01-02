require 'test_helper'

class ThumbnailsControllerTest < ActionController::TestCase
  def setup
    login_as('admin')
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should assign thumbnail to video" do
    get :assign, {:video_id => videos(:one).id, :thumbnail_id => thumbnails(:one).id}
    assert_response :success
  end
end
