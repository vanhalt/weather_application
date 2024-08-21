# Our internal Addresses API
class AddressesApi
  include HTTParty
  base_uri 'http://localhost:3001'

  def initialize(address)
    @options = {
      query: {
        address: address,
      },
      format: :plain
    }
  end

  # Get the current weather for the provided @options
  # returns:
  # =>{
  # "id": 1,
  # "region_code": "MX",
  # "administrative_area": "",
  # "locality": "",
  # "postal_code": "",
  # "detail": "",
  # "latitude": "000.000",
  # "longitude": "000.000",
  # "created_at": "2024-08-21T15:00:27.808Z",
  # "updated_at": "2024-08-21T15:00:27.808Z"
  # }
  def data
    response = self.class.get('/addresses/validate', @options)
    JSON.parse response, symbolize_names: true
  end
end
