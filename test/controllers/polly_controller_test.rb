require 'test_helper'

class PollyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get polly_index_url
    assert_response :success
  end

end
