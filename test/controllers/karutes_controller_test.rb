require 'test_helper'

class KarutesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get karutes_show_url
    assert_response :success
  end

end
