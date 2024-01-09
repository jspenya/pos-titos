require "test_helper"

class CustomerOrderControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_order_index_url
    assert_response :success
  end
end
