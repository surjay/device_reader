class DevicesController < ApplicationController
  def show
    if device.present?
      render json: {
        id: device.uid,
        cumulative_count: device.cumulative_count,
        latest_timestamp: device.latest_timestamp.to_s,
      }, status: :ok
    else
      render_error("Device not found", status: :not_found)
    end
  end

  private

  def device
    @device ||= Device.find(uid:).first # find returns a Set
  end

  def uid
    @uid ||= params[:id]
  end
end
