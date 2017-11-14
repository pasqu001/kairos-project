require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get add_photo" do
    get users_add_photo_url
    assert_response :success
  end

end
