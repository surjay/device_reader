# frozen_string_literal: true

class Device < Ohm::Model
  set :readings, :Reading

  attribute :uid
  index :uid
  unique :uid

  attribute :cumulative_count
  attribute :latest_timestamp
end