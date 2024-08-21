require 'test_helper'

class AddressValidatorServiceTest < Minitest::Test

  def test_raises_invalid_address_error_for_blank_address
    assert_raises AddressValidatorService::InvalidAddressError do
      AddressValidatorService.new("")
    end
  end

  def test_returns_first_similar_address_if_found
    address = "123 Main St, Anytown"
    similar_address = Address.new(detail: address)

    Address.stub(:similar_addresses_to, [similar_address]) do
      service = AddressValidatorService.new(address)
      assert_equal similar_address, service.call
    end
  end

  def test_raises_invalid_address_error_for_malformed_address_during_validation
    address = nil

    Address.stub(:similar_addresses_to, []) do
      assert_raises AddressValidatorService::InvalidAddressError do
        AddressValidatorService.new(address).call
      end
    end
  end
end
