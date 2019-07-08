require 'test_helper'

class TransfertsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transferts_index_url
    assert_response :success
  end

end
