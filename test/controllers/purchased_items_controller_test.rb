require 'test_helper'

class PurchasedItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchased_items_index_url
    assert_response :success
  end

  test "should get show" do
    get purchased_items_show_url
    assert_response :success
  end

  test "should get new" do
    get purchased_items_new_url
    assert_response :success
  end

  test "should get create" do
    get purchased_items_create_url
    assert_response :success
  end

  test "should get edit" do
    get purchased_items_edit_url
    assert_response :success
  end

  test "should get update" do
    get purchased_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get purchased_items_destroy_url
    assert_response :success
  end

end
