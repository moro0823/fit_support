require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get notes_new_url
    assert_response :success
  end

end
