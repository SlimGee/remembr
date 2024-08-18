require "test_helper"

class NoticeImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get notice_images_new_url
    assert_response :success
  end

  test "should get create" do
    get notice_images_create_url
    assert_response :success
  end
end
