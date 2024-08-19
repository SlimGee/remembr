require "test_helper"

class Dashboard::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_home_index_url
    assert_response :success
  end
end
