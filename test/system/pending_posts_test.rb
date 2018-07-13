require "application_system_test_case"

class PendingPostsTest < ApplicationSystemTestCase
  setup do
    @pending_post = pending_posts(:one)
  end

  test "visiting the index" do
    visit pending_posts_url
    assert_selector "h1", text: "Pending Posts"
  end

  test "creating a Pending post" do
    visit pending_posts_url
    click_on "New Pending Post"

    click_on "Create Pending post"

    assert_text "Pending post was successfully created"
    click_on "Back"
  end

  test "updating a Pending post" do
    visit pending_posts_url
    click_on "Edit", match: :first

    click_on "Update Pending post"

    assert_text "Pending post was successfully updated"
    click_on "Back"
  end

  test "destroying a Pending post" do
    visit pending_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pending post was successfully destroyed"
  end
end
