require 'test_helper'

class System::ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get system_profile_index_url
    assert_response :success
  end

  test "should get update" do
    get system_profile_update_url
    assert_response :success
  end

end
