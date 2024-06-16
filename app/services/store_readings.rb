# frozen_string_literal: true

class StoreReadings < ApplicationService
  def initialize(device:, readings:)
    @device = device
    @readings = readings
    @cumulative_count = @device.cumulative_count.presence.to_i || 0
    @latest_timestamp = @device.latest_timestamp
  end

  def call
    @readings.each { |reading| store_reading(reading) }

    @device.update(cumulative_count: @cumulative_count, latest_timestamp: @latest_timestamp)
  end

  private

  def store_reading(reading)
    count_str, timestamp_str = reading.values_at(:count, :timestamp)
    return if [count_str, timestamp_str].any?(&:blank?)

    timestamp = DateTime.parse(timestamp_str)
    count = count_str.to_i
    @device.readings.add(Reading.create(timestamp:, count:))

    update_device_attributes(count, timestamp)
  rescue Ohm::UniqueIndexViolation => _e
    # Duplicate reading - Log and keep processing
    Rails.logger.error("Duplicate reading for timestamp: #{timestamp}")
  end

  def update_device_attributes(count, timestamp)
    @cumulative_count += count

    if @latest_timestamp.blank? || timestamp > @latest_timestamp
      @latest_timestamp = timestamp
    end
  end
end