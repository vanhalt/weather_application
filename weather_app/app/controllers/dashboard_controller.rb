class DashboardController < ApplicationController
   before_action :set_address, only: [:index]

  def index
    @weather_data = WeatherService.call(@address)
  end

  private

    def set_address
      @address = params[:address]
    end
end
