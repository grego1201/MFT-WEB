require 'test_helper'

class GuidedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guided_index_url
    assert_response :success
  end

end
