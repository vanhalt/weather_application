# Open Meteo
#
# Only for non-commercial use and less than 10.000 daily API calls
class OpenMeteo
  include HTTParty
  base_uri 'https://api.open-meteo.com/v1' # v1 hardcoded. Area of improvement over here


  # lat: latitude
  # lon: longitude
  # current: current weather. Default is Air temperature at 2 meters above ground
  # timezone: Time zone in the form of America/*. Default is for the service to auto detect the time zone
  def initialize(lat, lon, current = :temperature_2m, timezone = :auto)
    @options = {
      query: {
        latitude: lat,
        longitude: lon,
        current: current,
        timezone: timezone
      },
      format: :plain
    }
  end

  # Get the current weather for the provided @options
  # returns:
  # => {
  # "latitude"=>52.52,
  # "longitude"=>13.419998,
  # "generationtime_ms"=>0.010013580322265625,
  # "utc_offset_seconds"=>7200,
  # "timezone"=>"Europe/Berlin",
  # "timezone_abbreviation"=>"CEST",
  # "elevation"=>38.0,
  # "current_units"=>{"time"=>"iso8601", "interval"=>"seconds", "temperature_2m"=>"°C"},
  # "current"=>{"time"=>"2024-08-21T08:45", "interval"=>900, "temperature_2m"=>19.5}
  # }
  def current_weather
    response = self.class.get('/forecast', @options)
    JSON.parse response, symbolize_names: true
  end
end
