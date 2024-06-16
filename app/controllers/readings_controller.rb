class ReadingsController < ApplicationController
  def create
    StoreReadings.call(device:, readings:)

    render json: { message: "Readings successfully stored" }, status: 200
  end

  private

  def device
    @device ||= Device.find(uid:).first.presence || Devise.create(uid:, cumulative_count: 0)
  end

  def uid
    @uid ||= params.require(:id)
  end

  def readings
    @readings ||= params.require(:readings)
  end
end
