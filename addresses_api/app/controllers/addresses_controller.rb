class AddressesController < ApplicationController
  # rate_limit to: 5, within: 3.minutes, with: -> { redirect_to new_session_url, alert: "Try again later." }, by: -> { request.domain }, store: Rails.cache

  before_action :set_address, only: [:validate]

  def validate
    validated_address = AddressValidatorService.call(@address)

    render json: validated_address
  rescue StandardError => e
    render json: { error: e.message, class: e.class }, status: :unprocessable_entity
  end

  private

    def set_address
      @address = params[:address]
    end
end
