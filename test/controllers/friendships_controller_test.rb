require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get friendships_create_url
    assert_response :success
  end

  test "should get destory" do
    get friendships_destory_url
    assert_response :success
  end

end
