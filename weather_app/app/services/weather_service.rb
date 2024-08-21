class WeatherService < ApplicationService
  def initialize(address)
    @address = address
  end

  def call
    return nil unless @address

    address_data = AddressesApi.new(@address).data
    zip_code = address_data[:postal_code]

    return { error: "Zipcode was not found due to: #{address_data[:error]}" } if zip_code.blank?

    cache = ZipCodeCache.new(zip_code)

    return cache.read if cache.exists?

    weather_data = OpenMeteo.new(address_data[:latitude], address_data[:longitude]).current_weather
    response = format_response(address_data, weather_data)

    cache.write(response)

    response
  end

  private

    def format_response(address_data, weather_data)
      {
        address: address_data[:detail],
        timezone: weather_data[:timezone],
        unit: weather_data[:current_units][:temperature_2m],
        temperature: weather_data[:current][:temperature_2m]
      }
    end
end
