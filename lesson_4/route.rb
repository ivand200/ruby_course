# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'

class Route
  include InstanceCounter
  include Validate

  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) if @stations.include?(station) && station != @stations.first && station != @stations.last
  end

  def list_stations
    @stations.each { |station| puts station.name }
  end

  private

  def validate!
    raise 'Start and end stations cannot be the same' if stations.first == stations.last
    raise 'Start station cannot be nil' if stations.first.nil?
    raise 'End station cannot be nil' if stations.last.nil?
  end
end
