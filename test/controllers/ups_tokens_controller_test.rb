require "test_helper"

class UpsTokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ups_token = ups_tokens(:one)
  end

  test "should get index" do
    get ups_tokens_url
    assert_response :success
  end

  test "should get new" do
    get new_ups_token_url
    assert_response :success
  end

  test "should create ups_token" do
    assert_difference("UpsToken.count") do
      post ups_tokens_url, params: { ups_token: { access_token: @ups_token.access_token, expires_at: @ups_token.expires_at, refresh_token: @ups_token.refresh_token, user_id: @ups_token.user_id } }
    end

    assert_redirected_to ups_token_url(UpsToken.last)
  end

  test "should show ups_token" do
    get ups_token_url(@ups_token)
    assert_response :success
  end

  test "should get edit" do
    get edit_ups_token_url(@ups_token)
    assert_response :success
  end

  test "should update ups_token" do
    patch ups_token_url(@ups_token), params: { ups_token: { access_token: @ups_token.access_token, expires_at: @ups_token.expires_at, refresh_token: @ups_token.refresh_token, user_id: @ups_token.user_id } }
    assert_redirected_to ups_token_url(@ups_token)
  end

  test "should destroy ups_token" do
    assert_difference("UpsToken.count", -1) do
      delete ups_token_url(@ups_token)
    end

    assert_redirected_to ups_tokens_url
  end
end
