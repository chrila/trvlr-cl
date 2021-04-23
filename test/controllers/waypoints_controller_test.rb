require "test_helper"

class WaypointsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get waypoints_index_url
    assert_response :success
  end

  test "should get new" do
    get waypoints_new_url
    assert_response :success
  end

  test "should get edit" do
    get waypoints_edit_url
    assert_response :success
  end
end
