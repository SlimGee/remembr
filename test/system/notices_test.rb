require "application_system_test_case"

class NoticesTest < ApplicationSystemTestCase
  setup do
    @notice = notices(:one)
  end

  test "visiting the index" do
    visit notices_url
    assert_selector "h1", text: "Notices"
  end

  test "should create notice" do
    visit notices_url
    click_on "New notice"

    fill_in "Category", with: @notice.category
    fill_in "Dob", with: @notice.dob
    fill_in "Dod", with: @notice.dod
    fill_in "First name", with: @notice.first_name
    fill_in "Last name", with: @notice.last_name
    fill_in "Location", with: @notice.location
    fill_in "Nickname", with: @notice.nickname
    fill_in "Platform", with: @notice.platform
    fill_in "Published at", with: @notice.published_at
    fill_in "Relationship", with: @notice.relationship
    fill_in "Wording", with: @notice.wording
    click_on "Create Notice"

    assert_text "Notice was successfully created"
    click_on "Back"
  end

  test "should update Notice" do
    visit notice_url(@notice)
    click_on "Edit this notice", match: :first

    fill_in "Category", with: @notice.category
    fill_in "Dob", with: @notice.dob
    fill_in "Dod", with: @notice.dod
    fill_in "First name", with: @notice.first_name
    fill_in "Last name", with: @notice.last_name
    fill_in "Location", with: @notice.location
    fill_in "Nickname", with: @notice.nickname
    fill_in "Platform", with: @notice.platform
    fill_in "Published at", with: @notice.published_at
    fill_in "Relationship", with: @notice.relationship
    fill_in "Wording", with: @notice.wording
    click_on "Update Notice"

    assert_text "Notice was successfully updated"
    click_on "Back"
  end

  test "should destroy Notice" do
    visit notice_url(@notice)
    click_on "Destroy this notice", match: :first

    assert_text "Notice was successfully destroyed"
  end
end
