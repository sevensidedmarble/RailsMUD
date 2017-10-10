require 'test_helper'

class WorldsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get worlds_show_url
    assert_response :success
  end

end
