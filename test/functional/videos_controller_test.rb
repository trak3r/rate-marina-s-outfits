require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should show video" do
    get :show, :id => videos(:one).id
    assert_response :success
  end

  test "should not rate video when logged in" do
    get :rate, {:id => videos(:one).id, :stars => (1+rand(5))}
    assert_response :redirect
  end

  test "should rate video when logged in" do
    login_as('ted')
    get :rate, {:id => videos(:one).id, :stars => (1+rand(5))}
    assert_response :success
  end
end
