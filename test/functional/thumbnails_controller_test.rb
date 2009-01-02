require 'test_helper'

class ThumbnailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thumbnails)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thumbnail" do
    assert_difference('Thumbnail.count') do
      post :create, :thumbnail => { }
    end

    assert_redirected_to thumbnail_path(assigns(:thumbnail))
  end

  test "should show thumbnail" do
    get :show, :id => thumbnails(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => thumbnails(:one).id
    assert_response :success
  end

  test "should update thumbnail" do
    put :update, :id => thumbnails(:one).id, :thumbnail => { }
    assert_redirected_to thumbnail_path(assigns(:thumbnail))
  end

  test "should destroy thumbnail" do
    assert_difference('Thumbnail.count', -1) do
      delete :destroy, :id => thumbnails(:one).id
    end

    assert_redirected_to thumbnails_path
  end
end
