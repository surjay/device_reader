# frozen_string_literal: true

class Reading < Ohm::Model
  reference :device, :Device

  attribute :timestamp
  unique :timestamp

  attribute :count
end
