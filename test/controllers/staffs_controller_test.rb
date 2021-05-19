require 'test_helper'

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get staffs_new_url
    assert_response :success
  end

  test "should get edit" do
    get staffs_edit_url
    assert_response :success
  end

  test "should get show" do
    get staffs_show_url
    assert_response :success
  end

end
