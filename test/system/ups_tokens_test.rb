require "application_system_test_case"

class UpsTokensTest < ApplicationSystemTestCase
  setup do
    @ups_token = ups_tokens(:one)
  end

  test "visiting the index" do
    visit ups_tokens_url
    assert_selector "h1", text: "Ups tokens"
  end

  test "should create ups token" do
    visit ups_tokens_url
    click_on "New ups token"

    fill_in "Access token", with: @ups_token.access_token
    fill_in "Expires at", with: @ups_token.expires_at
    fill_in "Refresh token", with: @ups_token.refresh_token
    fill_in "User", with: @ups_token.user_id
    click_on "Create Ups token"

    assert_text "Ups token was successfully created"
    click_on "Back"
  end

  test "should update Ups token" do
    visit ups_token_url(@ups_token)
    click_on "Edit this ups token", match: :first

    fill_in "Access token", with: @ups_token.access_token
    fill_in "Expires at", with: @ups_token.expires_at
    fill_in "Refresh token", with: @ups_token.refresh_token
    fill_in "User", with: @ups_token.user_id
    click_on "Update Ups token"

    assert_text "Ups token was successfully updated"
    click_on "Back"
  end

  test "should destroy Ups token" do
    visit ups_token_url(@ups_token)
    click_on "Destroy this ups token", match: :first

    assert_text "Ups token was successfully destroyed"
  end
end
