class AddressValidator
  include HTTParty
  base_uri 'https://addressvalidation.googleapis.com'

  HEADERS = { 'Content-Type' => 'application/json' }.freeze

  class HTTPClientError < StandardError; end

  def initialize(address)
    @address = address.split(',') # we get an ary of the full address
    @options = {
      query: {
        key: Rails.application.credentials.dig(:address_validation_api_key)
      },
      headers: HEADERS,
      format: :plain
    }
  end

  # Hit the API to get information about the address. From this response we only need:
  #  response["result"]["address"]["postalAddress"]["postalCode"]
  #
  # basic JSON response:
  # => {
  #   "result": {
  #     // Validation verdict.
  #     "verdict": {},
  #     // Address details determined by the API.
  #     "address": {},
  #     // The geocode generated for the input address.
  #     "geocode": {},
  #     // Information indicating if the address is a business, residence, etc.
  #     "metadata": {},
  #     // Information about the address from the US Postal Service
  #     // ("US" and "PR" addresses only).
  #     "uspsData": {},
  #   },
  #   // A unique identifier generated for every request to the API.
  #   "responseId": "ID"
  # }
  def validate!
    post(address_payload)[:result]
  end

  private

    def post(body)
      request_options = @options.dup.merge({ body: body })
      response = self.class.post('/v1:validateAddress', request_options)
      JSON.parse response, symbolize_names: true

    rescue StandardError => e
      raise HTTPClientError, e.message
    end

    # PostalAddress spec: https://developers.google.com/maps/documentation/address-validation/reference/rest/v1/TopLevel/validateAddress#postaladdress
    def address_payload
      { address: { addressLines: @address } }.to_json
    end
end
