class AddressValidatorService < ApplicationService

  class InvalidAddressError < StandardError; end
  class AddressCreationError < StandardError; end
  class WrongAddressError < StandardError; end

  def initialize(address)
    raise InvalidAddressError, 'Invalid address' if address.blank? || address.size < 12
    @address = address
  end

  def call
    potential_addresses = Address.similar_addresses_to(@address) # capturing errors from here

    return potential_addresses.first unless potential_addresses.empty? || potential_addresses.length > 5

    validate_and_store! @address
  rescue ActiveRecord::StatementInvalid
    raise InvalidAddressError, 'Malformed address'
  end

  private

    def validate_and_store!(a)
      response = AddressValidator.new(a).validate!

      if response[:verdict][:addressComplete]
        address = Address.create_from_validator_data(response) # capturing errors from here
        return address if address.valid?
      end

      raise WrongAddressError, 'Seems like this address does not exist'
    rescue ActiveRecord::RecordInvalid => e
      raise AddressCreationError, e.message
    end
end
