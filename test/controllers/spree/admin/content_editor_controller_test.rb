require 'test_helper'

class Spree::Admin::ContentEditorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get spree_admin_content_editor_index_url
    assert_response :success
  end

  test "should get show" do
    get spree_admin_content_editor_show_url
    assert_response :success
  end

  test "should get update" do
    get spree_admin_content_editor_update_url
    assert_response :success
  end

  test "should get destroy" do
    get spree_admin_content_editor_destroy_url
    assert_response :success
  end

end
