# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validate'
require_relative 'accessor'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validate
  include Validation
  include Accessors

  attr_accessor_with_history :stations

  validate :stations, :type, Array

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
end
