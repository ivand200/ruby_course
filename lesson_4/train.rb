# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'
require_relative 'accessor'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  include Accessors

  attr_accessor_with_history :speed

  attr_reader :number, :type, :carriages

  strong_attr_accessor :type, Symbol

  validate :number, :presence
  validate :number, :format, /^[a-z\d]{3}-?[a-z\d]{2}$/i

  @@trains = {}
  def initialize(number, type)

    @number = number
    self.type = type
    self.speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def speed_up(amount)
    @speed += amount
  end

  def brake
    @speed = 0
  end

  def add_carriage(carriage)
    @carriages << carriage if speed.zero? && carriage_compatible?(carriage)
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if speed.zero?
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
  end

  def move_forward
    return unless next_station

    current_station.send_train(self)
    @current_station_index += 1
    current_station.accept_train(self)
  end

  def move_backward
    return unless previous_station

    current_station.send_train(self)
    @current_station_index -= 1
    current_station.accept_train(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def self.find(number)
    @@trains[number]
  end

  def each_carriage(&block)
    carriages.each(&block)
  end

  def carriages
    @carriages ||= []
  end

  protected

  # These methods are protected because they are intended to be used internally by the class and its subclasses.
  # External methods, objects should not directly manipulate train within a route.

  def next_station
    @route.stations[@current_station_index + 1] if @current_station_index < @route.stations.size - 1
  end

  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index.positive?
  end

  private

  # This method is private because it's an internal check to ensure that only compatible carriages added to the train.
  # External methods, objects should not be concerned with internal logic of compatibility.

  def carriage_compatible?(carriage)
    carriage.type == @type
  end
end
