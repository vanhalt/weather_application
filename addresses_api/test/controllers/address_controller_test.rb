require 'test_helper'

class AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should validate address and return response" do

    valid_address = "123 Main St, Anytown, CA 94110"

    # GET request with the address
    get "/addresses/validate?address=#{valid_address}"

    # Assert successful response and content type
    assert_response :success
    assert_equal "application/json; charset=utf-8", response.content_type

    # Parse JSON response (adjust structure if needed)
    parsed_response = JSON.parse(response.body)
    assert_not_nil parsed_response
  end

  test "should return error for invalid address" do
    invalid_address = nil

    # GET request with the address
    get "/addresses/validate?address=#{invalid_address}"

    # Assert error response and status code
    assert_response :unprocessable_entity
    assert_equal "application/json; charset=utf-8", response.content_type

    # Parse JSON response (adjust structure if needed)
    parsed_response = JSON.parse(response.body)
    assert_equal "Invalid address", parsed_response["error"]
  end
end
