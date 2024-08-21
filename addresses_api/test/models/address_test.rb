require "test_helper"

class AddressTest < ActiveSupport::TestCase
  test "validates presence of detail and postal_code" do
    address = Address.new(detail: nil, postal_code: nil)

    assert_not address.valid?
    assert_includes address.errors.full_messages, "Detail can't be blank"
    assert_includes address.errors.full_messages, "Postal code can't be blank"
  end

  test "similar_addresses_to returns similar addresses" do
     address1 = Address.create(detail: "123 Main St, Anytown", postal_code: 1)
     address2 = Address.create(detail: "123 Main Street, Anytown", postal_code: 2)

     similar_addresses = Address.similar_addresses_to("123 Main St")
     assert_includes similar_addresses, address1
     assert_includes similar_addresses, address2
   end

  test "create_from_validator_data raises exception with invalid data" do
    assert_raise do
      Address.create_from_validator_data(nil)
    end # -> pass
  end

  test "create_from_validator_data creates address correctly" do
    data = HashWithIndifferentAccess.new({
      address: {
        postalAddress: {
          regionCode: "US",
          administrativeArea: "CA",
          locality: "San Francisco",
          postalCode: "94110"
        },
        formattedAddress: "123 Main St, San Francisco, CA 94110"
      },
      geocode: {
        location: {
          latitude: "37.7749",
          longitude: "-122.4194"
        }
      }
    })

    address = Address.create_from_validator_data(data)

    assert_equal "US", address.region_code
    assert_equal "CA", address.administrative_area
    assert_equal "San Francisco", address.locality
    assert_equal "94110", address.postal_code
    assert_equal "123 Main St, San Francisco, CA 94110", address.detail
    assert_equal "37.7749", address.latitude
    assert_equal "-122.4194", address.longitude
  end
end
