require 'test_helper'

class FillFencerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fill_fencer_index_url
    assert_response :success
  end

end
