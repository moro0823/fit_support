require 'test_helper'

class AdminUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_users_show_url
    assert_response :success
  end

end
